import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/connection_request_model/connection_request_model.dart';
import 'package:laiza/data/repositories/connections_repository/connections_repository.dart';

part 'connection_request_event.dart';
part 'connection_request_state.dart';

class ConnectionRequestBloc
    extends Bloc<ConnectionRequestEvent, ConnectionRequestState> {
  final ConnectionsRepository _connectionsRepository;
  List<ConnectionRequest> _requestList = <ConnectionRequest>[];

  ConnectionRequestBloc(this._connectionsRepository)
      : super(ConnectionRequestInitial()) {
    on<ConnectionRequestLoadEvent>(_onConnectionRequestLoad);
    on<ConnectionRequestChangeStatusEvent>(_onConnectionRequestChangeStatus);
  }

  FutureOr<void> _onConnectionRequestLoad(ConnectionRequestLoadEvent event,
      Emitter<ConnectionRequestState> emit) async {
    emit(ConnectionRequestLoading());
    _requestList = await _connectionsRepository.getConnectionRequests();
    emit(ConnectionRequestLoaded(_requestList));
  }

  FutureOr<void> _onConnectionRequestChangeStatus(
      ConnectionRequestChangeStatusEvent event,
      Emitter<ConnectionRequestState> emit) {
    _connectionsRepository.acceptRejectConnection(
        id: event.id, status: event.status);
    if (event.status == ConnectionRequestStatus.rejected) {
      _requestList = List<ConnectionRequest>.from(_requestList)
        ..removeWhere((item) => event.id == item.id);
      emit(ConnectionRequestLoaded(_requestList));
    } else {
      _requestList = _requestList.map((element) {
        if (element.id == event.id) {
          return element.copyWith(status: event.status);
        }
        return element;
      }).toList();
      emit(ConnectionRequestLoaded(_requestList));
    }
  }
}

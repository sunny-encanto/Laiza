import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/connection_request_model/connection_request_model.dart';

part 'connection_request_event.dart';
part 'connection_request_state.dart';

class ConnectionRequestBloc
    extends Bloc<ConnectionRequestEvent, ConnectionRequestState> {
  List<ConnectionRequestModel> _requestList = connectionRequestList;
  ConnectionRequestBloc() : super(ConnectionRequestInitial()) {
    on<ConnectionRequestLoadEvent>(_onConnectionRequestLoad);
    on<ConnectionRequestChangeStatusEvent>(_onConnectionRequestChangeStatus);
  }

  FutureOr<void> _onConnectionRequestLoad(ConnectionRequestLoadEvent event,
      Emitter<ConnectionRequestState> emit) async {
    emit(ConnectionRequestLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(ConnectionRequestLoaded(_requestList));
  }

  FutureOr<void> _onConnectionRequestChangeStatus(
      ConnectionRequestChangeStatusEvent event,
      Emitter<ConnectionRequestState> emit) {
    if (event.status == ConnectionRequestStatus.rejected.name) {
      _requestList = List<ConnectionRequestModel>.from(_requestList)
        ..removeWhere((item) => event.id == item.id);
      emit(ConnectionRequestLoaded(_requestList));
    } else {
      _requestList = _requestList.map((element) {
        if (element.id == event.id) {
          return element.copyWith(requestStatus: event.status);
        }
        return element;
      }).toList();
      emit(ConnectionRequestLoaded(_requestList));
    }
  }
}

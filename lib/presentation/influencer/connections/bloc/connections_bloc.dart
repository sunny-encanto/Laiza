import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/connections_model/connections_model.dart';

part 'connections_event.dart';
part 'connections_state.dart';

class ConnectionsBloc extends Bloc<ConnectionsEvent, ConnectionsState> {
  ConnectionsBloc() : super(ConnectionsInitial()) {
    on<FetchConnectionsEvent>(_onConnectionsLoaded);

    on<SearchConnectionsEvent>(_onSearchConnections);
  }

  FutureOr<void> _onConnectionsLoaded(event, emit) async {
    emit(ConnectionsLoadingSate());
    await Future.delayed(const Duration(seconds: 1));
    emit(ConnectionsLoadedState(connectionsList));
  }

  FutureOr<void> _onSearchConnections(
      SearchConnectionsEvent event, emit) async {
    List<ConnectionsModel> filteredList = connectionsList
        .where((connection) =>
            connection.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(ConnectionsLoadedState(filteredList));
  }
}

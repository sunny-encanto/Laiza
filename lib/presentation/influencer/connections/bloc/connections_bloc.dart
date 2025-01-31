import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/my_connections_model/my_connections_model.dart';
import 'package:laiza/data/repositories/connections_repository/connections_repository.dart';

part 'connections_event.dart';
part 'connections_state.dart';

class ConnectionsBloc extends Bloc<ConnectionsEvent, ConnectionsState> {
  final ConnectionsRepository _connectionsRepository;
  List<Connection> myConnections = <Connection>[];

  ConnectionsBloc(this._connectionsRepository) : super(ConnectionsInitial()) {
    on<FetchConnectionsEvent>(_onConnectionsLoaded);

    on<SearchConnectionsEvent>(_onSearchConnections);
  }

  FutureOr<void> _onConnectionsLoaded(event, emit) async {
    emit(ConnectionsLoadingSate());
    myConnections = await _connectionsRepository.getMyConnections();
    emit(ConnectionsLoadedState(myConnections));
  }

  FutureOr<void> _onSearchConnections(
      SearchConnectionsEvent event, emit) async {
    List<Connection> filteredList = myConnections
        .where((connection) =>
            connection.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(ConnectionsLoadedState(filteredList));
  }
}

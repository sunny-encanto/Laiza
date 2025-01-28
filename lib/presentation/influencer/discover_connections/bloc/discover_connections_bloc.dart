import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/connections_model/connections_model.dart';
import 'package:laiza/data/repositories/connections_repository/connections_repository.dart';

import '../../../../data/models/user/user_model.dart';

part 'discover_connections_event.dart';
part 'discover_connections_state.dart';

class DiscoverConnectionsBloc
    extends Bloc<DiscoverConnectionsEvent, DiscoverConnectionsState> {
  final UserRepository _userRepository;
  final ConnectionsRepository _connectionsRepository = ConnectionsRepository();
  List<ConnectionsModel> _connectionsList = <ConnectionsModel>[];

  DiscoverConnectionsBloc(this._userRepository)
      : super(DiscoverConnectionsInitial()) {
    on<DiscoverConnectionsFetchEvent>(_onDiscoverConnectionLoad);
    on<DiscoverConnectionsSearchEvent>(_onDiscoverConnectionsSearch);
    on<SendConnectionEvent>(_onSendConnection);
    on<SendFilterConnectionEvent>(_onSendFilterConnection);
    on<CrossConnectionEvent>(_onCrossConnection);
    on<CrossFilterConnectionEvent>(_onCrossFilterConnection);
  }

  FutureOr<void> _onDiscoverConnectionLoad(DiscoverConnectionsEvent event,
      Emitter<DiscoverConnectionsState> emit) async {
    emit(DiscoverConnectionsLoading());
    List<UserModel> users = await _userRepository.getAllSeller();
    for (var user in users) {
      _connectionsList.add(ConnectionsModel(
        id: int.parse(user.id ?? '0'),
        name: user.name ?? "",
        category: '',
        profile: user.profileImg ?? "",
        isConnected: false,
      ));
    }
    emit(DiscoverConnectionsLoaded(_connectionsList));
  }

  FutureOr<void> _onDiscoverConnectionsSearch(
      DiscoverConnectionsSearchEvent event,
      Emitter<DiscoverConnectionsState> emit) {
    final List<ConnectionsModel> updatedList = _connectionsList
        .where((item) =>
            item.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(DiscoverConnectionsFilterLoaded(updatedList));
  }

  FutureOr<void> _onSendConnection(
      SendConnectionEvent event, Emitter<DiscoverConnectionsState> emit) async {
    _connectionsList = _connectionsList.map((item) {
      if (event.id == item.id) {
        _connectionsRepository.sendConnection(event.id);
        return item.copyWith(isConnected: !item.isConnected);
      }
      return item;
    }).toList();
    emit(DiscoverConnectionsLoaded(_connectionsList));
  }

  FutureOr<void> _onSendFilterConnection(
      SendFilterConnectionEvent event, Emitter<DiscoverConnectionsState> emit) {
    final currentState = state as DiscoverConnectionsFilterLoaded;
    List<ConnectionsModel> filterConnectionsList =
        currentState.connections.map((item) {
      if (event.id == item.id) {
        _connectionsRepository.sendConnection(event.id);
        return item.copyWith(isConnected: !item.isConnected);
      }
      return item;
    }).toList();
    emit(DiscoverConnectionsFilterLoaded(filterConnectionsList));
  }

  FutureOr<void> _onCrossConnection(
      CrossConnectionEvent event, Emitter<DiscoverConnectionsState> emit) {
    emit(DiscoverConnectionsLoading());
    _connectionsList.removeWhere((item) => item.id == event.id);
    emit(DiscoverConnectionsLoaded(_connectionsList));
  }

  FutureOr<void> _onCrossFilterConnection(CrossFilterConnectionEvent event,
      Emitter<DiscoverConnectionsState> emit) {
    final DiscoverConnectionsFilterLoaded currentState =
        state as DiscoverConnectionsFilterLoaded;
    List<ConnectionsModel> filterConnectionsList = currentState.connections;
    emit(DiscoverConnectionsLoading());
    filterConnectionsList.removeWhere((item) => item.id == event.id);
    emit(DiscoverConnectionsFilterLoaded(filterConnectionsList));
  }
}

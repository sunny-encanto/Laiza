import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/connections_model/connections_model.dart';

part 'discover_connections_event.dart';
part 'discover_connections_state.dart';

class DiscoverConnectionsBloc
    extends Bloc<DiscoverConnectionsEvent, DiscoverConnectionsState> {
  DiscoverConnectionsBloc() : super(DiscoverConnectionsInitial()) {
    on<DiscoverConnectionsEvent>(_onDiscoverConnectionLoad);
    on<DiscoverConnectionsSearchEvent>(_onDiscoverConnectionsSearch);
  }

  FutureOr<void> _onDiscoverConnectionLoad(DiscoverConnectionsEvent event,
      Emitter<DiscoverConnectionsState> emit) async {
    emit(DiscoverConnectionsLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(DiscoverConnectionsLoaded(connectionsList));
  }

  FutureOr<void> _onDiscoverConnectionsSearch(
      DiscoverConnectionsSearchEvent event,
      Emitter<DiscoverConnectionsState> emit) {
    final updatedList = connectionsList
        .where((item) =>
            item.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(DiscoverConnectionsLoaded(updatedList));
  }
}

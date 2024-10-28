import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/connections_model/connections_model.dart';

part 'followers_event.dart';
part 'followers_state.dart';

class FollowersBloc extends Bloc<FollowersEvent, FollowersState> {
  List<ConnectionsModel> _followersList = connectionsList;
  FollowersBloc() : super(FollowersInitial()) {
    on<FollowersFetchEvent>(_onFetchFollowers);
    on<FollowersRemoveEvent>(_onFollowersRemoveEvent);
    on<FollowersSearch>(_onFollowersSearch);
  }

  FutureOr<void> _onFetchFollowers(
      FollowersFetchEvent event, Emitter<FollowersState> emit) async {
    emit(FollowersLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(FollowersLoaded(connectionsList));
  }

  FutureOr<void> _onFollowersRemoveEvent(
      FollowersRemoveEvent event, Emitter<FollowersState> emit) {
    final updatedItems = List<ConnectionsModel>.from(_followersList)
      ..removeWhere((item) => item.id == event.id);
    emit(FollowersLoaded(updatedItems));
    // Update the original itemList to reflect the removal
    _followersList = updatedItems;
  }

  FutureOr<void> _onFollowersSearch(
      FollowersSearch event, Emitter<FollowersState> emit) {
    if (event.query.isEmpty) {
      emit(FollowersLoaded(_followersList));
    }
    final updatedList = _followersList
        .where((item) =>
            item.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(FollowersLoaded(updatedList));
  }
}

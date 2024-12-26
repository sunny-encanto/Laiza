import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/followers_model/follower.dart';
import 'package:laiza/data/repositories/follow_repository/follow_repository.dart';

part 'followers_event.dart';
part 'followers_state.dart';

class FollowersBloc extends Bloc<FollowersEvent, FollowersState> {
  final FollowersRepository _followersRepository;
  List<Follower> _followersList = <Follower>[];

  FollowersBloc(this._followersRepository) : super(FollowersInitial()) {
    on<FollowersFetchEvent>(_onFetchFollowers);
    on<FollowersRemoveEvent>(_onFollowersRemoveEvent);
    on<FollowersSearch>(_onFollowersSearch);
  }

  FutureOr<void> _onFetchFollowers(
      FollowersFetchEvent event, Emitter<FollowersState> emit) async {
    emit(FollowersLoading());
    _followersList = await _followersRepository.getFollowers();
    emit(FollowersLoaded(_followersList));
  }

  FutureOr<void> _onFollowersRemoveEvent(
      FollowersRemoveEvent event, Emitter<FollowersState> emit) {
    final updatedItems = List<Follower>.from(_followersList)
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

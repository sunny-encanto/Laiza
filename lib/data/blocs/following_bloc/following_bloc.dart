import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/followers_model/follower.dart';
import 'package:laiza/data/repositories/follow_repository/follow_repository.dart';

part 'following_event.dart';
part 'following_state.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  final FollowersRepository _followersRepository;

  FollowingBloc(this._followersRepository) : super(FollowingInitial()) {
    on<FetchFollowings>(_onFetchFollowings);
  }

  FutureOr<void> _onFetchFollowings(
      FetchFollowings event, Emitter<FollowingState> emit) async {
    try {
      emit(FollowingLoading());
      List<Follower> followings = await _followersRepository.getFollowings();
      emit(FollowingLoadedState(followings));
    } catch (e) {
      emit(FollowingErrorState(e.toString()));
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/reels_model/reel.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';

import '../../../data/repositories/follow_repository/follow_repository.dart';

part 'reel_event.dart';
part 'reel_state.dart';

class ReelBloc extends Bloc<ReelEvent, ReelState> {
  final ReelRepository _reelRepository;
  List<Reel> reels = <Reel>[];

  ReelBloc(this._reelRepository) : super(ReelInitial()) {
    // Handle loading of reels
    on<LoadReelEvent>(_onLoadReels);

    on<ReelFollowRequestEvent>(_onFollowRequest);
    on<ToggleReelLikeButtonEvent>(_onToggleLikeButton);
  }

  Future<void> _onLoadReels(
      LoadReelEvent event, Emitter<ReelState> emit) async {
    emit(ReelLoading());
    try {
      reels = await _reelRepository.getAllReels();
      emit(ReelLoaded(reels));
    } catch (e) {
      emit(ReelError(e.toString()));
    }
  }

  FutureOr<void> _onFollowRequest(
      ReelFollowRequestEvent event, Emitter<ReelState> emit) async {
    if (event.isFollowed) {
      FollowersRepository().follow(event.id.toString());
    } else {
      FollowersRepository().unFollow(event.id.toString());
    }
    emit(ReelFollowRequestState(event.isFollowed));
  }

  FutureOr<void> _onToggleLikeButton(
      ToggleReelLikeButtonEvent event, Emitter<ReelState> emit) {
    reels = reels.map((item) {
      if (item.id == event.id) {
        if (item.likeStatus == 0) {
          _reelRepository.addReelLike(event.id);
          return item.copyWith(likeStatus: 1, likesCount: item.likesCount + 1);
        } else {
          _reelRepository.removeReelLike(event.id);
          return item.copyWith(likeStatus: 0, likesCount: item.likesCount - 1);
        }
      }
      return item;
    }).toList();
    emit(ReelLoaded(reels));
  }
}

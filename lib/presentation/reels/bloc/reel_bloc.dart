import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

part 'reel_event.dart';
part 'reel_state.dart';

class ReelBloc extends Bloc<ReelEvent, ReelState> {
  ReelBloc() : super(ReelLoading()) {
    // Handle loading of reels
    on<LoadReels>(_onLoadReels);

    // Handle page changes
    on<ChangeReelPage>(_onChangeReelPage);
    on<ReelFollowRequestEvent>(_onFollowRequest);
  }

  Future<void> _onLoadReels(LoadReels event, Emitter<ReelState> emit) async {
    emit(ReelLoading());
    try {
      final List<String> reelVideos = event.reelUrls;

      // Initialize the first video controller
      VideoPlayerController videoController =
          // ignore: deprecated_member_use
          VideoPlayerController.network(reelVideos[0]);

      await videoController.initialize();
      videoController.setLooping(true);
      videoController.play();

      // Ensure the video is initialized before emitting the loaded state
      if (videoController.value.isInitialized) {
        emit(ReelLoaded(
            reels: reelVideos,
            videoController: videoController,
            currentPage: 0));
      } else {
        emit(const ReelError('Video failed to initialize'));
      }
    } catch (e) {
      emit(const ReelError('Failed to load reels'));
    }
  }

  Future<void> _onChangeReelPage(
      ChangeReelPage event, Emitter<ReelState> emit) async {
    final currentState = state;
    if (currentState is ReelLoaded) {
      // Dispose of the previous controller
      currentState.videoController.dispose();

      // Initialize a new video controller for the new page
      VideoPlayerController newController =
          // ignore: deprecated_member_use
          VideoPlayerController.network(currentState.reels[event.page]);
      await newController.initialize();
      newController.setLooping(true);
      newController.play();

      emit(ReelLoaded(
        reels: currentState.reels,
        videoController: newController,
        currentPage: event.page,
      ));
    }
  }

  FutureOr<void> _onFollowRequest(
      ReelFollowRequestEvent event, Emitter<ReelState> emit) async {
    emit(ReelFollowRequestState(event.isFollowed));
  }
}

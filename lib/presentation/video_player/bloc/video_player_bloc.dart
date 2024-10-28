import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  late VideoPlayerController _controller;

  VideoPlayerBloc(String videoUrl) : super(VideoPlayerLoading()) {
    _initializeVideoPlayer(videoUrl);
  }

  Future<void> _initializeVideoPlayer(String videoUrl) async {
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        add(VideoPlayerInitialized());
        _controller.setLooping(true);
        _controller.play();
      });
    on<VideoPlayerInitialized>(onVideoPlayerInitialized);

    on<VideoPlayerPlay>(onVideoPlayerPlay);

    on<VideoPlayerPause>(onVideoPlayerPause);
  }

  @override
  Future<void> close() {
    _controller.dispose();
    return super.close();
  }

  FutureOr<void> onVideoPlayerInitialized(
      VideoPlayerInitialized event, Emitter<VideoPlayerState> emit) {
    emit(VideoPlayerReady(controller: _controller));
  }

  FutureOr<void> onVideoPlayerPlay(
      VideoPlayerPlay event, Emitter<VideoPlayerState> emit) {
    _controller.play();
  }

  FutureOr<void> onVideoPlayerPause(
      VideoPlayerPause event, Emitter<VideoPlayerState> emit) {
    _controller.pause();
  }
}

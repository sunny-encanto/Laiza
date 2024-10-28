part of 'video_player_bloc.dart';

sealed class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object> get props => [];
}

class VideoPlayerInitialized extends VideoPlayerEvent {}

class VideoPlayerPlay extends VideoPlayerEvent {}

class VideoPlayerPause extends VideoPlayerEvent {}

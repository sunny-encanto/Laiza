part of 'video_player_bloc.dart';

sealed class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object> get props => [];
}

final class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

class VideoPlayerError extends VideoPlayerState {
  final String message;

  const VideoPlayerError(this.message);

  @override
  List<Object> get props => [message];
}

class VideoPlayerReady extends VideoPlayerState {
  final VideoPlayerController controller;

  const VideoPlayerReady({required this.controller});

  @override
  List<Object> get props => [controller];
}

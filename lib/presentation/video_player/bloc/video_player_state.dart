part of 'video_player_bloc.dart';

sealed class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object> get props => [];
}

final class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

class VideoPlayerReady extends VideoPlayerState {
  final VideoPlayerController controller;

  const VideoPlayerReady({required this.controller});

  @override
  List<Object> get props => [controller];
}

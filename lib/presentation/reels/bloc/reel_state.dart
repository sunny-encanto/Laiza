part of 'reel_bloc.dart';

sealed class ReelState extends Equatable {
  const ReelState();

  @override
  List<Object> get props => [];
}

final class ReelInitial extends ReelState {}

class ReelLoading extends ReelState {}

class ReelLoaded extends ReelState {
  final List<String> reels;
  final VideoPlayerController videoController;
  final int currentPage;

  const ReelLoaded(
      {required this.reels,
      required this.videoController,
      required this.currentPage});

  @override
  List<Object> get props => [reels, videoController, currentPage];
}

class ReelError extends ReelState {
  final String message;

  const ReelError(this.message);

  @override
  List<Object> get props => [message];
}

class ReelFollowRequestState extends ReelState {
  final bool isFollowed;
  const ReelFollowRequestState(this.isFollowed);
  @override
  List<Object> get props => [isFollowed];
}

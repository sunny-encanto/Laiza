part of 'reel_bloc.dart';

sealed class ReelState extends Equatable {
  const ReelState();

  @override
  List<Object> get props => [];
}

final class ReelInitial extends ReelState {}

class ReelLoading extends ReelState {}

class ReelLoaded extends ReelState {
  final List<Reel> reels;

  const ReelLoaded(this.reels);

  @override
  List<Object> get props => [reels];
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

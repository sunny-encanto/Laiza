part of 'my_reel_bloc.dart';

sealed class MyReelState extends Equatable {
  const MyReelState();

  @override
  List<Object> get props => [];
}

final class MyReelInitial extends MyReelState {}

class MyReelLoading extends MyReelState {}

class MyReelLoaded extends MyReelState {
  final List<Reel> reels;

  const MyReelLoaded(this.reels);

  @override
  List<Object> get props => [reels];
}

class MyReelError extends MyReelState {
  final String message;

  const MyReelError(this.message);

  @override
  List<Object> get props => [message];
}

class ToggleMyReelLikeButton extends MyReelState {
  final int isLiked;

  const ToggleMyReelLikeButton(this.isLiked);

  @override
  List<Object> get props => [isLiked];
}

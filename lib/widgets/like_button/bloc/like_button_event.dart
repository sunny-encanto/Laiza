part of 'like_button_bloc.dart';

sealed class LikeButtonEvent extends Equatable {
  const LikeButtonEvent();

  @override
  List<Object> get props => [];
}

class LikeButtonPressEvent extends LikeButtonEvent {
  final bool isLiked;
  final int reelId;

  const LikeButtonPressEvent({required this.isLiked, required this.reelId});

  @override
  List<Object> get props => [isLiked, reelId];
}

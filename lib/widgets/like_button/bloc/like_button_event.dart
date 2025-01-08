part of 'like_button_bloc.dart';

sealed class LikeButtonEvent extends Equatable {
  const LikeButtonEvent();

  @override
  List<Object> get props => [];
}

class LikeButtonPressEvent extends LikeButtonEvent {
  final bool isLiked;

  const LikeButtonPressEvent(this.isLiked);

  @override
  List<Object> get props => [isLiked];
}

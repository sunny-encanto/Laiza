part of 'like_button_bloc.dart';

sealed class LikeButtonState extends Equatable {
  const LikeButtonState();

  @override
  List<Object> get props => [];
}

final class LikeButtonInitial extends LikeButtonState {}

class LikeButtonPressState extends LikeButtonState {
  final bool isLIked;
  const LikeButtonPressState(this.isLIked);
  @override
  List<Object> get props => [isLIked];
}

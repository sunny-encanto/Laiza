part of 'my_reel_bloc.dart';

sealed class MyReelEvent extends Equatable {
  const MyReelEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyReelEvent extends MyReelEvent {}

class ToggleMyReelLikeButtonEvent extends MyReelEvent {
  final int id;

  const ToggleMyReelLikeButtonEvent(this.id);

  @override
  List<Object?> get props => [id];
}

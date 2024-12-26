part of 'following_bloc.dart';

sealed class FollowingEvent extends Equatable {
  const FollowingEvent();

  @override
  List<Object?> get props => [];
}

class FetchFollowings extends FollowingEvent {}

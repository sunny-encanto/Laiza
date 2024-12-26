part of 'following_bloc.dart';

sealed class FollowingState extends Equatable {
  const FollowingState();

  @override
  List<Object> get props => [];
}

final class FollowingInitial extends FollowingState {}

final class FollowingLoading extends FollowingState {}

final class FollowingErrorState extends FollowingState {
  final String message;

  const FollowingErrorState(this.message);

  @override
  List<Object> get props => [message];
}

final class FollowingLoadedState extends FollowingState {
  final List<Follower> followings;

  const FollowingLoadedState(this.followings);

  @override
  List<Object> get props => [followings];
}

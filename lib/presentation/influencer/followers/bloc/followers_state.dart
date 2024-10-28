part of 'followers_bloc.dart';

sealed class FollowersState extends Equatable {
  const FollowersState();

  @override
  List<Object> get props => [];
}

final class FollowersInitial extends FollowersState {}

final class FollowersLoading extends FollowersState {}

final class FollowersError extends FollowersState {
  final String message;
  const FollowersError(this.message);
  @override
  List<Object> get props => [message];
}

final class FollowersLoaded extends FollowersState {
  final List<ConnectionsModel> followers;
  const FollowersLoaded(this.followers);
  @override
  List<Object> get props => [followers];
}

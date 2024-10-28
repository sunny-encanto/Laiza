part of 'followers_bloc.dart';

sealed class FollowersEvent extends Equatable {
  const FollowersEvent();

  @override
  List<Object> get props => [];
}

class FollowersFetchEvent extends FollowersEvent {}

class FollowersRemoveEvent extends FollowersEvent {
  final int id;
  const FollowersRemoveEvent(this.id);
  @override
  List<Object> get props => [id];
}

class FollowersSearch extends FollowersEvent {
  final String query;
  const FollowersSearch(this.query);
  @override
  List<Object> get props => [query];
}

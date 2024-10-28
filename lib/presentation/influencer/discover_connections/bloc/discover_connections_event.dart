part of 'discover_connections_bloc.dart';

sealed class DiscoverConnectionsEvent extends Equatable {
  const DiscoverConnectionsEvent();

  @override
  List<Object> get props => [];
}

class DiscoverConnectionsFetchEvent extends DiscoverConnectionsEvent {}

class DiscoverConnectionsSearchEvent extends DiscoverConnectionsEvent {
  final String query;
  const DiscoverConnectionsSearchEvent(this.query);
  @override
  List<Object> get props => [query];
}

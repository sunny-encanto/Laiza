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

class SendConnectionEvent extends DiscoverConnectionsEvent {
  final int id;

  const SendConnectionEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SendFilterConnectionEvent extends DiscoverConnectionsEvent {
  final int id;

  const SendFilterConnectionEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CrossConnectionEvent extends DiscoverConnectionsEvent {
  final int id;

  const CrossConnectionEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CrossFilterConnectionEvent extends DiscoverConnectionsEvent {
  final int id;

  const CrossFilterConnectionEvent(this.id);

  @override
  List<Object> get props => [id];
}

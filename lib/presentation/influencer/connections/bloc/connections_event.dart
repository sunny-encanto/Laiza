part of 'connections_bloc.dart';

sealed class ConnectionsEvent extends Equatable {
  const ConnectionsEvent();

  @override
  List<Object> get props => [];
}

class FetchConnectionsEvent extends ConnectionsEvent {}

class SearchConnectionsEvent extends ConnectionsEvent {
  final String query;

  const SearchConnectionsEvent(this.query);
  @override
  List<Object> get props => [query];
}

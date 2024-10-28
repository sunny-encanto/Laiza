part of 'discover_connections_bloc.dart';

sealed class DiscoverConnectionsState extends Equatable {
  const DiscoverConnectionsState();

  @override
  List<Object> get props => [];
}

final class DiscoverConnectionsInitial extends DiscoverConnectionsState {}

final class DiscoverConnectionsLoading extends DiscoverConnectionsState {}

final class DiscoverConnectionsError extends DiscoverConnectionsState {
  final String message;
  const DiscoverConnectionsError(this.message);
  @override
  List<Object> get props => [message];
}

final class DiscoverConnectionsLoaded extends DiscoverConnectionsState {
  final List<ConnectionsModel> connections;
  const DiscoverConnectionsLoaded(this.connections);
  @override
  List<Object> get props => [connections];
}

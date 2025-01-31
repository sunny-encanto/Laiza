part of 'connections_bloc.dart';

sealed class ConnectionsState extends Equatable {
  const ConnectionsState();

  @override
  List<Object> get props => [];
}

final class ConnectionsInitial extends ConnectionsState {}

final class ConnectionsLoadingSate extends ConnectionsState {}

final class ConnectionsErrorState extends ConnectionsState {
  final String message;

  const ConnectionsErrorState(this.message);

  @override
  List<Object> get props => [message];
}

final class ConnectionsLoadedState extends ConnectionsState {
  final List<Connection> connections;

  const ConnectionsLoadedState(this.connections);

  @override
  List<Object> get props => [connections];
}

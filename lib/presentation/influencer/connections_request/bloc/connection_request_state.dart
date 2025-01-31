part of 'connection_request_bloc.dart';

sealed class ConnectionRequestState extends Equatable {
  const ConnectionRequestState();

  @override
  List<Object> get props => [];
}

final class ConnectionRequestInitial extends ConnectionRequestState {}

final class ConnectionRequestLoading extends ConnectionRequestState {}

final class ConnectionRequestError extends ConnectionRequestState {
  final String message;

  const ConnectionRequestError(this.message);

  @override
  List<Object> get props => [message];
}

final class ConnectionRequestLoaded extends ConnectionRequestState {
  final List<ConnectionRequest> requestList;

  const ConnectionRequestLoaded(this.requestList);

  @override
  List<Object> get props => [requestList];
}

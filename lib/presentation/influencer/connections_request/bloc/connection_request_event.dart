part of 'connection_request_bloc.dart';

sealed class ConnectionRequestEvent extends Equatable {
  const ConnectionRequestEvent();

  @override
  List<Object> get props => [];
}

class ConnectionRequestLoadEvent extends ConnectionRequestEvent {}

class ConnectionRequestChangeStatusEvent extends ConnectionRequestEvent {
  final String status;
  final int id;

  const ConnectionRequestChangeStatusEvent(
      {required this.id, required this.status});
  @override
  List<Object> get props => [status];
}

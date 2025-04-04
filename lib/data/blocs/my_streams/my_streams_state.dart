part of 'my_streams_bloc.dart';

sealed class MyStreamsState extends Equatable {
  const MyStreamsState();

  @override
  List<Object> get props => [];
}

final class MyStreamsInitial extends MyStreamsState {}

final class MyStreamsLoading extends MyStreamsState {}

final class MyStreamsError extends MyStreamsState {
  final String message;

  const MyStreamsError(this.message);

  @override
  List<Object> get props => [message];
}

final class MyStreamsLoaded extends MyStreamsState {
  final List<MyScheduledStream> streams;

  const MyStreamsLoaded(this.streams);

  @override
  List<Object> get props => [streams];
}

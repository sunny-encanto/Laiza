part of 'up_coming_stream_bloc.dart';

sealed class UpComingStreamEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUpcomingStream extends UpComingStreamEvent {}

class NotifyStream extends UpComingStreamEvent {
  final String id;

  NotifyStream(this.id);

  @override
  List<Object?> get props => [id];
}

part of 'up_coming_stream_bloc.dart';

sealed class UpComingStreamEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUpcomingStream extends UpComingStreamEvent {}

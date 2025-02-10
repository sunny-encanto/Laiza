part of 'up_coming_stream_bloc.dart';

sealed class UpComingStreamState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class UpComingStreamInitial extends UpComingStreamState {}

final class UpComingStreamLoading extends UpComingStreamState {}

final class UpComingStreamError extends UpComingStreamState {
  final String message;

  UpComingStreamError(this.message);

  @override
  List<Object?> get props => [message];
}

final class UpComingStreamLoaded extends UpComingStreamState {
  final List<UpComingStream> upcomingStreams;

  UpComingStreamLoaded(this.upcomingStreams);

  @override
  List<Object?> get props => [upcomingStreams];
}

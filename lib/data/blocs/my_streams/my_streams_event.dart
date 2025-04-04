part of 'my_streams_bloc.dart';

sealed class MyStreamsEvent extends Equatable {
  const MyStreamsEvent();

  @override
  List<Object?> get props => [];
}

class FetchMyStreams extends MyStreamsEvent {}

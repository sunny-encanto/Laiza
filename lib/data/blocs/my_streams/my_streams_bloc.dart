import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/my_scheduled_stream_model/my_scheduled_stream_model.dart';
import '../../repositories/live_stream_repository/live_stream_repository.dart';

part 'my_streams_event.dart';
part 'my_streams_state.dart';

class MyStreamsBloc extends Bloc<MyStreamsEvent, MyStreamsState> {
  final LiveStreamRepository _liveStreamRepository;

  MyStreamsBloc(this._liveStreamRepository) : super(MyStreamsInitial()) {
    on<FetchMyStreams>(_onFetchStreams);
  }

  FutureOr<void> _onFetchStreams(
      FetchMyStreams event, Emitter<MyStreamsState> emit) async {
    try {
      emit(MyStreamsLoading());
      List<MyScheduledStream> streams =
          await _liveStreamRepository.getMyStreams();
      emit(MyStreamsLoaded(streams));
    } catch (e) {
      emit(MyStreamsError(e.toString()));
    }
  }
}

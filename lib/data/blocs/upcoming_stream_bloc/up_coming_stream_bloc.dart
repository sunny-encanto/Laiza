import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/repositories/live_stream_repository/live_stream_repository.dart';

import '../../models/upcoming_stream_model/upcoming_stream_model.dart';

part 'up_coming_stream_event.dart';
part 'up_coming_stream_state.dart';

class UpComingStreamBloc
    extends Bloc<UpComingStreamEvent, UpComingStreamState> {
  final LiveStreamRepository _liveStreamRepository;

  UpComingStreamBloc(this._liveStreamRepository)
      : super(UpComingStreamInitial()) {
    on<FetchUpcomingStream>(_onFetchUpcomingStream);
  }

  FutureOr<void> _onFetchUpcomingStream(
      FetchUpcomingStream event, Emitter<UpComingStreamState> emit) async {
    try {
      emit(UpComingStreamLoading());
      List<UpComingStream> upcomingStreams =
          await _liveStreamRepository.getAllStream();
      emit(UpComingStreamLoaded(upcomingStreams));
    } catch (e) {
      emit(UpComingStreamError(e.toString()));
    }
  }
}

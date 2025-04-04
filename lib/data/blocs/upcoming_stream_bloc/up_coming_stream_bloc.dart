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
  List<UpComingStream> upcomingStreams = <UpComingStream>[];

  UpComingStreamBloc(this._liveStreamRepository)
      : super(UpComingStreamInitial()) {
    on<FetchUpcomingStream>(_onFetchUpcomingStream);
    on<NotifyStream>(_onNotifyStream);
  }

  FutureOr<void> _onFetchUpcomingStream(
      FetchUpcomingStream event, Emitter<UpComingStreamState> emit) async {
    try {
      emit(UpComingStreamLoading());
      upcomingStreams = await _liveStreamRepository.getAllStream();
      emit(UpComingStreamLoaded(upcomingStreams));
    } catch (e) {
      emit(UpComingStreamError(e.toString()));
    }
  }

  FutureOr<void> _onNotifyStream(
      NotifyStream event, Emitter<UpComingStreamState> emit) {
    try {
      upcomingStreams = upcomingStreams.map((item) {
        _liveStreamRepository.notifyMe(event.id);
        if (item.id.toString() == event.id) {
          return item.copyWith(isNotify: !item.isNotify);
        }
        return item;
      }).toList();
      emit(UpComingStreamLoaded(upcomingStreams));
    } catch (e) {
      print(e.toString());
    }
  }
}

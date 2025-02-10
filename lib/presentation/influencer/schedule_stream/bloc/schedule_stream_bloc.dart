import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/models/live_stream_model.dart/live_stream_model.dart';
import 'package:laiza/data/repositories/live_stream_repository/live_stream_repository.dart';
import 'package:laiza/data/services/firebase_services.dart';

import '../../../../core/app_export.dart';

part 'schedule_stream_event.dart';
part 'schedule_stream_state.dart';

class ScheduleStreamBloc
    extends Bloc<ScheduleStreamEvent, ScheduleStreamState> {
  final LiveStreamRepository _liveStreamRepository;

  ScheduleStreamBloc(this._liveStreamRepository)
      : super(ScheduleStreamInitial()) {
    on<SelectDateEvent>(_onSelectDate);
    on<SelectTimeEvent>(_onSelectTime);
    on<ScheduleNowRequestEvent>(_onScheduleNow);
    on<GoLiveButtonTapEvent>(_onGoLive);
  }

  FutureOr<void> _onSelectDate(
      SelectDateEvent event, Emitter<ScheduleStreamState> emit) {
    emit(DatePickerSelected(event.selectedDate));
  }

  FutureOr<void> _onSelectTime(
      SelectTimeEvent event, Emitter<ScheduleStreamState> emit) {
    emit(TimePickerSelected(event.pickedTime));
  }

  FutureOr<void> _onScheduleNow(
      ScheduleNowRequestEvent event, Emitter<ScheduleStreamState> emit) async {
    try {
      emit(ScheduleStreamLoading());
      CommonModel model = await _liveStreamRepository.addStream(
        title: event.title,
        description: event.description,
        date: event.date,
        time: event.time,
        productIds: [],
      );
      emit(ScheduleStreamSuccess(model.message ?? ''));
    } catch (e) {
      emit(ScheduleStreamError(e.toString()));
    }
  }

  FutureOr<void> _onGoLive(
      GoLiveButtonTapEvent event, Emitter<ScheduleStreamState> emit) async {
    emit(ScheduleStreamLoading());
    await FirebaseServices.addOnGoingLiveStream(event.liveStreamModel);
    emit(const ScheduleStreamSuccess('Success'));
  }
}

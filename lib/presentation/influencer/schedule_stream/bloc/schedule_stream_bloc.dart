import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/live_stream_model.dart/live_stream_model.dart';
import 'package:laiza/data/services/firebase_services.dart';

import '../../../../core/app_export.dart';

part 'schedule_stream_event.dart';
part 'schedule_stream_state.dart';

class ScheduleStreamBloc
    extends Bloc<ScheduleStreamEvent, ScheduleStreamState> {
  ScheduleStreamBloc() : super(ScheduleStreamInitial()) {
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
    emit(ScheduleStreamLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(ScheduleStreamSuccess());
  }

  FutureOr<void> _onGoLive(
      GoLiveButtonTapEvent event, Emitter<ScheduleStreamState> emit) async {
    emit(ScheduleStreamLoading());
    await FirebaseServices.addOnGoingLiveStream(event.liveStreamModel);
    emit(ScheduleStreamSuccess());
  }
}

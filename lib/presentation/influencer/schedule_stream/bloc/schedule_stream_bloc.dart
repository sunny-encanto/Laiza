import 'dart:async';

import 'package:equatable/equatable.dart';

import '../../../../core/app_export.dart';

part 'schedule_stream_event.dart';
part 'schedule_stream_state.dart';

class ScheduleStreamBloc
    extends Bloc<ScheduleStreamEvent, ScheduleStreamState> {
  ScheduleStreamBloc() : super(ScheduleStreamInitial()) {
    on<SelectDateEvent>(_onSelectDate);
    on<SelectTimeEvent>(_onSelectTime);
    on<ScheduleNowRequestEvent>(_onScheduleNow);
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
}

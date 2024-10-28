part of 'schedule_stream_bloc.dart';

sealed class ScheduleStreamState extends Equatable {
  const ScheduleStreamState();

  @override
  List<Object> get props => [];
}

final class ScheduleStreamInitial extends ScheduleStreamState {}

final class ScheduleStreamLoading extends ScheduleStreamState {}

final class ScheduleStreamError extends ScheduleStreamState {
  final String message;
  const ScheduleStreamError(this.message);
  @override
  List<Object> get props => [message];
}

final class ScheduleStreamSuccess extends ScheduleStreamState {}

class DatePickerSelected extends ScheduleStreamState {
  final DateTime selectedDate;

  const DatePickerSelected(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}

class TimePickerSelected extends ScheduleStreamState {
  final TimeOfDay pickedTime;

  const TimePickerSelected(this.pickedTime);

  @override
  List<Object> get props => [pickedTime];
}

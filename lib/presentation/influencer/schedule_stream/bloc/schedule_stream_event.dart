part of 'schedule_stream_bloc.dart';

sealed class ScheduleStreamEvent extends Equatable {
  const ScheduleStreamEvent();

  @override
  List<Object> get props => [];
}

class SelectDateEvent extends ScheduleStreamEvent {
  final DateTime selectedDate;

  const SelectDateEvent(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}

class SelectTimeEvent extends ScheduleStreamEvent {
  final TimeOfDay pickedTime;
  const SelectTimeEvent(this.pickedTime);

  @override
  List<Object> get props => [pickedTime];
}

class ScheduleNowRequestEvent extends ScheduleStreamEvent {
  final String title;
  final String description;
  final String date;
  final String time;
  final String link;

  const ScheduleNowRequestEvent({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.link,
  });

  @override
  List<Object> get props => [title, description, date, time, link];
}

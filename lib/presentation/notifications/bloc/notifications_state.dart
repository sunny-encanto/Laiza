part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoadingState extends NotificationsState {}

final class NotificationsErrorState extends NotificationsState {
  final String message;

  const NotificationsErrorState(this.message);

  @override
  List<Object> get props => [message];
}

final class NotificationsLoaded extends NotificationsState {
  final List<Notification> notification;

  const NotificationsLoaded(this.notification);

  @override
  List<Object> get props => [notification];
}

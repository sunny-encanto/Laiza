import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/notifications_model/notifications_model.dart';
import 'package:laiza/data/repositories/notification_repository/notification_repository.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository _notificationRepository;

  NotificationsBloc(this._notificationRepository)
      : super(NotificationsInitial()) {
    on<NotificationFetchEvent>(_onFetchNotifications);
  }

  FutureOr<void> _onFetchNotifications(
      NotificationFetchEvent event, Emitter<NotificationsState> emit) async {
    try {
      emit(NotificationsLoadingState());
      List<Notification> notification =
          await _notificationRepository.getNotifications();
      emit(NotificationsLoaded(notification));
    } catch (e) {
      emit(NotificationsErrorState(e.toString()));
    }
  }
}

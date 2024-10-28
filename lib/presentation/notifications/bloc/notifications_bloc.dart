import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<NotificationFetchEvent>(_onFetchNotifications);
  }

  FutureOr<void> _onFetchNotifications(
      NotificationFetchEvent event, Emitter<NotificationsState> emit) async {
    try {
      emit(NotificationsLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      emit(const NotificationsLoaded([]));
    } catch (e) {
      emit(const NotificationsErrorState('Failed to load Notifications'));
    }
  }
}

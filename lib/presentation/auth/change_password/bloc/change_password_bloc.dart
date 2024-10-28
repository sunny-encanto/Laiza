import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<ChangePasswordSubmitRequest>(onSubmitRequest);
    on<NewPasswordToggle>(onNewPasswordToggle);
    on<ReEnteredNewPasswordToggle>(onReEnterPasswordToggle);
  }

  FutureOr<void> onSubmitRequest(event, emit) async {
    emit(ChangePasswordLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(ChangePasswordSuccess());
  }

  FutureOr<void> onNewPasswordToggle(event, emit) async {
    emit(NewPasswordToggleState(event.isVisible));
  }

  FutureOr<void> onReEnterPasswordToggle(event, emit) async {
    emit(ReEnterNewPasswordToggleState(event.isVisible));
  }
}

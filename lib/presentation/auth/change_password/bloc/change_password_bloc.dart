import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/repositories/auth_repository/auth_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AuthRepository _authRepository;
  ChangePasswordBloc(this._authRepository) : super(ChangePasswordInitial()) {
    on<ChangePasswordSubmitRequest>(onSubmitRequest);
    on<NewPasswordToggle>(onNewPasswordToggle);
    on<ReEnteredNewPasswordToggle>(onReEnterPasswordToggle);
  }

  FutureOr<void> onNewPasswordToggle(event, emit) async {
    emit(NewPasswordToggleState(event.isVisible));
  }

  FutureOr<void> onReEnterPasswordToggle(event, emit) async {
    emit(ReEnterNewPasswordToggleState(event.isVisible));
  }

  FutureOr<void> onSubmitRequest(ChangePasswordSubmitRequest event,
      Emitter<ChangePasswordState> emit) async {
    try {
      emit(ChangePasswordLoading());
      CommonModel model = await _authRepository.resetPassword(
          email: event.email,
          password: event.newPassword,
          confirmPassword: event.confirmPassword);
      emit(ChangePasswordSuccess(model.message ?? ''));
    } catch (e) {
      emit(ChangePasswordError(e.toString()));
    }
  }
}

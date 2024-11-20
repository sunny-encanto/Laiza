import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/data/repositories/auth_repository/auth_repository.dart';

import '../../../../data/models/common_model/common_model.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository _authRepository;
  ForgotPasswordBloc(this._authRepository) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordSubmitRequest>(onSubmitRequest);
  }

  FutureOr<void> onSubmitRequest(ForgotPasswordSubmitRequest event,
      Emitter<ForgotPasswordState> emit) async {
    try {
      emit(ForgotPasswordLoadingState());
      CommonModel model =
          await _authRepository.forgotPassword(email: event.email);
      emit(ForgotPasswordSuccessState(
          message: model.message ?? "", userId: model.userId ?? 0));
    } catch (e) {
      emit(ForgotPasswordErrorState(e.toString()));
    }
  }
}

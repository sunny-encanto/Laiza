import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordSubmitRequest>(onSubmitRequest);
  }

  FutureOr<void> onSubmitRequest(event, emit) async {
    emit(ForgotPasswordLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(ForgotPasswordSuccessState());
  }
}

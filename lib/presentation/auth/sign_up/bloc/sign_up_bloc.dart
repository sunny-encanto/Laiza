import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laiza/presentation/auth/sign_up/bloc/sign_up_event.dart';
import 'package:laiza/presentation/auth/sign_up/bloc/sign_up_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState.initial()) {
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ToggleReEnterPasswordVisibility>(_onToggleReEnterPasswordVisibility);

    on<SignUpButtonPressed>(_onSignUpButtonPressed);
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<SignUpState> emit) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onToggleReEnterPasswordVisibility(
      ToggleReEnterPasswordVisibility event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
        isReEnterPasswordVisible: !state.isReEnterPasswordVisible));
  }

  void _onSignUpButtonPressed(
      SignUpButtonPressed event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      // Simulate authentication process
      await Future.delayed(const Duration(seconds: 2));

      // You can add your actual login logic here
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (_) {
      emit(state.copyWith(isSubmitting: false, isFailure: true));
    }
  }
}

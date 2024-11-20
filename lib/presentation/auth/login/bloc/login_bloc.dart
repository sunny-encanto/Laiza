import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laiza/data/models/login_model/login_model.dart';
import 'package:laiza/data/repositories/auth_repository/auth_repository.dart';
import 'package:laiza/data/services/firebase_services.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LoginWithGoggleEvent>(_onLoginWithGoogle);
    on<LoginWithPhoneEvent>(_onLoginWithPhone);
    on<LoginWithAppleEvent>(_onLoginWithAppleEvent);
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    emit(LoginPasswordToggleState(event.isVisible));
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      LoginModel loginModel = await _authRepository.login(
          email: event.email, password: event.password);
      emit(LoginSuccessState(loginModel.data?.user?.id ?? 0));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  FutureOr<void> _onLoginWithPhone(
      LoginWithPhoneEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(const LoginSuccessState(0));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  FutureOr<void> _onVerifyOtp(
      VerifyOtpEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(const LoginSuccessState(0));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  FutureOr<void> _onLoginWithGoogle(
      LoginWithGoggleEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      User? user = await FirebaseServices.signInWithGoogle();
      if (user != null) {
        emit(const LoginSuccessState(0));
      }
    } catch (e) {
      emit(const LoginError('Login Failed'));
    }
  }

  FutureOr<void> _onLoginWithAppleEvent(
      LoginWithAppleEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      User? user = await FirebaseServices.signInWithApple();
      if (user != null) {
        emit(const LoginSuccessState(0));
      }
    } catch (e) {
      emit(const LoginError('Login Failed'));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laiza/data/models/signup_model/signup_model.dart';
import 'package:laiza/data/repositories/auth_repository/auth_repository.dart';
import 'package:laiza/presentation/auth/sign_up/bloc/sign_up_event.dart';
import 'package:laiza/presentation/auth/sign_up/bloc/sign_up_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;
  SignUpBloc(this._authRepository) : super(SignUpInitialState()) {
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ToggleReEnterPasswordVisibility>(_onToggleReEnterPasswordVisibility);

    on<SignUpButtonPressed>(_onSignUpButtonPressed);
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<SignUpState> emit) {
    emit(TogglePasswordVisibleState(isVisible: !event.isVisible));
  }

  void _onToggleReEnterPasswordVisibility(
      ToggleReEnterPasswordVisibility event, Emitter<SignUpState> emit) {
    emit(ToggleReInterPasswordVisibleState(isVisible: !event.isVisible));
  }

  void _onSignUpButtonPressed(
      SignUpButtonPressed event, Emitter<SignUpState> emit) async {
    emit(SignUpLoadingState());
    try {
      // Simulate authentication process
      // await Future.delayed(const Duration(seconds: 2));
      SignupModel responseData = await _authRepository.signUp(
          name: event.name,
          email: event.email,
          password: event.password,
          userType: event.userType);
      emit(SignUpSuccessStates(
          userId: responseData.userId ?? 0,
          message: responseData.message ?? ''));
    } catch (e) {
      emit(SignUpErrorState(message: e.toString()));
    }
  }
}

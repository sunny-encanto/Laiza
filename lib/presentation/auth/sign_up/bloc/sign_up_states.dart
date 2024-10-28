import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isReEnterPasswordVisible;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const SignUpState({
    required this.email,
    required this.password,
    required this.isPasswordVisible,
    required this.isReEnterPasswordVisible,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  // Initial state of the form
  factory SignUpState.initial() {
    return const SignUpState(
      email: '',
      password: '',
      isPasswordVisible: false,
      isReEnterPasswordVisible: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  // Copy the current state with new values
  SignUpState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isReEnterPasswordVisible,
    bool? isFormValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isReEnterPasswordVisible:
          isReEnterPasswordVisible ?? this.isReEnterPasswordVisible,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        isPasswordVisible,
        isReEnterPasswordVisible,
        isSubmitting,
        isSuccess,
        isFailure,
      ];
}

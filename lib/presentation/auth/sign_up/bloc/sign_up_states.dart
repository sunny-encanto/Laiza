import 'package:equatable/equatable.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String message;

  const SignUpErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class SignUpSuccessStates extends SignUpState {
  final int userId;
  final String message;

  const SignUpSuccessStates({required this.userId, required this.message});
  @override
  List<Object> get props => [userId, message];
}

class TogglePasswordVisibleState extends SignUpState {
  final bool isVisible;

  const TogglePasswordVisibleState({required this.isVisible});
  @override
  List<Object> get props => [isVisible];
}

class ToggleReInterPasswordVisibleState extends SignUpState {
  final bool isVisible;

  const ToggleReInterPasswordVisibleState({required this.isVisible});
  @override
  List<Object> get props => [isVisible];
}
// import 'package:equatable/equatable.dart';

// class SignUpState extends Equatable {
//   final String email;
//   final String password;
//   final bool isPasswordVisible;
//   final bool isReEnterPasswordVisible;
//   final bool isSubmitting;
//   final bool isSuccess;
//   final bool isFailure;
//   final String message;

//   const SignUpState({
//     required this.email,
//     required this.password,
//     required this.isPasswordVisible,
//     required this.isReEnterPasswordVisible,
//     required this.isSubmitting,
//     required this.isSuccess,
//     required this.isFailure,
//     required this.message,
//   });

//   // Initial state of the form
//   factory SignUpState.initial() {
//     return const SignUpState(
//       email: '',
//       password: '',
//       message: '',
//       isPasswordVisible: false,
//       isReEnterPasswordVisible: false,
//       isSubmitting: false,
//       isSuccess: false,
//       isFailure: false,
//     );
//   }

//   // Copy the current state with new values
//   SignUpState copyWith({
//     String? email,
//     String? password,
//     bool? isPasswordVisible,
//     bool? isReEnterPasswordVisible,
//     bool? isFormValid,
//     bool? isSubmitting,
//     bool? isSuccess,
//     bool? isFailure,
//     String? message,
//   }) {
//     return SignUpState(
//       email: email ?? this.email,
//       password: password ?? this.password,
//       isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
//       isReEnterPasswordVisible:
//           isReEnterPasswordVisible ?? this.isReEnterPasswordVisible,
//       isSubmitting: isSubmitting ?? this.isSubmitting,
//       isSuccess: isSuccess ?? this.isSuccess,
//       isFailure: isFailure ?? this.isFailure,
//       message: message ?? this.message,
//     );
//   }

//   @override
//   List<Object> get props => [
//         email,
//         password,
//         isPasswordVisible,
//         isReEnterPasswordVisible,
//         isSubmitting,
//         isSuccess,
//         isFailure,
//         message
//       ];
// }

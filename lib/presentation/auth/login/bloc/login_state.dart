import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
  @override
  List<Object> get props => [message];
}

final class LoginSuccessState extends LoginState {
  final int userId;
  final bool isProfileComplete;
  const LoginSuccessState(
      {required this.userId, required this.isProfileComplete});
  @override
  List<Object> get props => [userId, isProfileComplete];
}

final class SocialLoginSuccessState extends LoginState {
  const SocialLoginSuccessState();
  @override
  List<Object> get props => [];
}

final class LoginPasswordToggleState extends LoginState {
  final bool isVisible;
  const LoginPasswordToggleState(this.isVisible);
  @override
  List<Object> get props => [isVisible];
}

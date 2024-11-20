part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoadingState extends ForgotPasswordState {}

final class ForgotPasswordErrorState extends ForgotPasswordState {
  final String message;
  const ForgotPasswordErrorState(this.message);

  @override
  List<Object> get props => [message];
}

final class ForgotPasswordSuccessState extends ForgotPasswordState {
  final String message;
  final int userId;
  const ForgotPasswordSuccessState(
      {required this.userId, required this.message});
  @override
  List<Object> get props => [message, userId];
}

part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordSubmitRequest extends ChangePasswordEvent {
  final String email;
  final String newPassword;
  final String confirmPassword;
  const ChangePasswordSubmitRequest(
      {required this.newPassword,
      required this.email,
      required this.confirmPassword});
  @override
  List<Object> get props => [newPassword];
}

class NewPasswordToggle extends ChangePasswordEvent {
  final bool isVisible;
  const NewPasswordToggle(this.isVisible);
  @override
  List<Object> get props => [isVisible];
}

class ReEnteredNewPasswordToggle extends ChangePasswordEvent {
  final bool isVisible;
  const ReEnteredNewPasswordToggle(this.isVisible);
  @override
  List<Object> get props => [isVisible];
}

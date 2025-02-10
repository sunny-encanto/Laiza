part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class CreatePasswordSubmitRequest extends ChangePasswordEvent {
  final String email;
  final String newPassword;
  final String confirmPassword;

  const CreatePasswordSubmitRequest(
      {required this.newPassword,
      required this.email,
      required this.confirmPassword});

  @override
  List<Object> get props => [newPassword, email, confirmPassword];
}

class ChangePasswordSubmitRequest extends ChangePasswordEvent {
  final String password;
  final String newPassword;

  const ChangePasswordSubmitRequest(
      {required this.password, required this.newPassword});

  @override
  List<Object> get props => [newPassword, password];
}

class NewPasswordToggle extends ChangePasswordEvent {
  final bool isVisible;

  const NewPasswordToggle(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}

class CurrentPasswordToggle extends ChangePasswordEvent {
  final bool isVisible;

  const CurrentPasswordToggle(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}

class ReEnteredNewPasswordToggle extends ChangePasswordEvent {
  final bool isVisible;

  const ReEnteredNewPasswordToggle(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}

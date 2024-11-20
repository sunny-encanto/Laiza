part of 'change_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordError extends ChangePasswordState {
  final String message;
  const ChangePasswordError(this.message);
  @override
  List<Object> get props => [message];
}

final class ChangePasswordSuccess extends ChangePasswordState {
  final String message;
  const ChangePasswordSuccess(this.message);
  @override
  List<Object> get props => [message];
}

final class NewPasswordToggleState extends ChangePasswordState {
  final bool isVisible;
  const NewPasswordToggleState(this.isVisible);
  @override
  List<Object> get props => [isVisible];
}

final class ReEnterNewPasswordToggleState extends ChangePasswordState {
  final bool isVisible;
  const ReEnterNewPasswordToggleState(this.isVisible);
  @override
  List<Object> get props => [isVisible];
}

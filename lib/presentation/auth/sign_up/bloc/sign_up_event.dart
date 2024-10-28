import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

// Toggle password visibility
class TogglePasswordVisibility extends SignUpEvent {}
// Toggle  re-enter password visibility

class ToggleReEnterPasswordVisibility extends SignUpEvent {}

// Event for sign up button pressed
class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String password;

  const SignUpButtonPressed(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

// Toggle password visibility
class TogglePasswordVisibility extends SignUpEvent {
  final bool isVisible;

  const TogglePasswordVisibility({required this.isVisible});
  @override
  List<Object> get props => [isVisible];
}
// Toggle  re-enter password visibility

class ToggleReEnterPasswordVisibility extends SignUpEvent {
  final bool isVisible;
  const ToggleReEnterPasswordVisibility({required this.isVisible});
  @override
  List<Object> get props => [isVisible];
}

// Event for sign up button pressed
class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String password;
  final String name;
  final String userType;
  const SignUpButtonPressed(
      {required this.email,
      required this.password,
      required this.name,
      required this.userType});

  @override
  List<Object> get props => [email, password, name, userType];
}

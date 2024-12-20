import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// Toggle password visibility
class TogglePasswordVisibility extends LoginEvent {
  final bool isVisible;

  const TogglePasswordVisibility(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}

// Event for login button pressed
class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LoginWithGoggleEvent extends LoginEvent {}

class LoginWithAppleEvent extends LoginEvent {}

class LoginWithPhoneEvent extends LoginEvent {
  final String phone;

  const LoginWithPhoneEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

// class VerifyOtpEvent extends LoginEvent {
//   final String otp;
//   const VerifyOtpEvent(this.otp);
//   @override
//   List<Object> get props => [otp];
// }

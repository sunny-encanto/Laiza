part of 'otp_screen_bloc.dart';

sealed class OtpScreenEvent extends Equatable {
  const OtpScreenEvent();

  @override
  List<Object> get props => [];
}

class OtpSubmitEvent extends OtpScreenEvent {
  final String email;
  final String otp;
  final String authType;

  const OtpSubmitEvent(
      {required this.email, required this.otp, required this.authType});

  @override
  List<Object> get props => [email, otp];
}

class OtpResnetEvent extends OtpScreenEvent {
  final int userId;
  final String email;

  const OtpResnetEvent(this.email, {required this.userId});

  @override
  List<Object> get props => [userId];
}

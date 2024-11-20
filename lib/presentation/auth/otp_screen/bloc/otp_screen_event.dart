part of 'otp_screen_bloc.dart';

sealed class OtpScreenEvent extends Equatable {
  const OtpScreenEvent();

  @override
  List<Object> get props => [];
}

class OtpSubmitEvent extends OtpScreenEvent {
  final int userId;
  final String otp;
  const OtpSubmitEvent({required this.userId, required this.otp});
  @override
  List<Object> get props => [userId, otp];
}

class OtpResnetEvent extends OtpScreenEvent {
  final int userId;
  final String email;

  const OtpResnetEvent(this.email, {required this.userId});
  @override
  List<Object> get props => [userId];
}

part of 'otp_screen_bloc.dart';

sealed class OtpScreenState extends Equatable {
  const OtpScreenState();

  @override
  List<Object> get props => [];
}

final class OtpScreenInitial extends OtpScreenState {}

final class OtpScreenScreenLoadingState extends OtpScreenState {}

final class OtpScreenErrorState extends OtpScreenState {
  final String message;

  const OtpScreenErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class OtpScreenSuccessState extends OtpScreenState {
  final String message;
  final String token;

  const OtpScreenSuccessState({required this.message, required this.token});

  @override
  List<Object> get props => [message];
}

final class OtpResentSuccessState extends OtpScreenState {
  final String message;

  const OtpResentSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

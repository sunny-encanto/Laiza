import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/repositories/auth_repository/auth_repository.dart';

import '../../../../data/models/otp_verification_model/otp_verification_model.dart';

part 'otp_screen_event.dart';
part 'otp_screen_state.dart';

class OtpScreenBloc extends Bloc<OtpScreenEvent, OtpScreenState> {
  final AuthRepository _authRepository;

  OtpScreenBloc(this._authRepository) : super(OtpScreenInitial()) {
    on<OtpSubmitEvent>(onSubmit);
    on<OtpResnetEvent>(onResentOtp);
  }

  FutureOr<void> onSubmit(
      OtpSubmitEvent event, Emitter<OtpScreenState> emit) async {
    try {
      emit(OtpScreenScreenLoadingState());
      OtpVerificationModel otpVerificationModel =
          await _authRepository.verifyOtp(email: event.email, otp: event.otp);
      await PrefUtils.setToken(otpVerificationModel.token ?? '');
      emit(OtpScreenSuccessState(
          message: otpVerificationModel.message ?? "",
          token: otpVerificationModel.token ?? ""));
    } catch (e) {
      emit(OtpScreenErrorState(message: e.toString()));
    }
  }

  FutureOr<void> onResentOtp(
      OtpResnetEvent event, Emitter<OtpScreenState> emit) async {
    try {
      emit(OtpScreenScreenLoadingState());
      CommonModel model = await _authRepository.resendOtp(email: event.email);
      emit(OtpResentSuccessState(message: model.message ?? ""));
    } catch (e) {
      emit(OtpScreenErrorState(message: e.toString()));
    }
  }
}

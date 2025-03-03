import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/data/services/firebase_services.dart';

import '../../../../data/models/otp_verification_model/otp_verification_model.dart';
import '../../../../data/services/firebase_messaging_service.dart';

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
          await _authRepository.verifyOtp(
              email: event.email, otp: event.otp, authType: event.authType);
      await PrefUtils.setToken(otpVerificationModel.token ?? '');
      await PrefUtils.setId(otpVerificationModel.userId.toString());
      if (event.authType == 'signUp') {
        UserModel userModel = await UserRepository().getUserProfile();
        //------//
        String fcmToken = await FirebaseMessagingService.generateToken() ?? "";
        UserModel user = UserModel(
          id: userModel.id.toString(),
          profileImg: userModel.profileImg.toString(),
          email: userModel.email,
          token: fcmToken,
          name: userModel.name,
          role: PrefUtils.getRole(),
        );
        await FirebaseServices.addUser(user);
        //------//
      }
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

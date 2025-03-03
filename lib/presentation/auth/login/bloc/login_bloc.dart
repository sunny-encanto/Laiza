import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/login_model/login_model.dart';
import 'package:laiza/data/services/firebase_messaging_service.dart';
import 'package:laiza/data/services/firebase_services.dart';

import '../../../../core/app_export.dart';
import '../../../../data/models/user/user_model.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LoginWithGoggleEvent>(_onLoginWithGoogle);
    on<LoginWithPhoneEvent>(_onLoginWithPhone);
    on<LoginWithAppleEvent>(_onLoginWithAppleEvent);
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    emit(LoginPasswordToggleState(event.isVisible));
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      LoginModel loginModel = await _authRepository.login(
          email: event.email, password: event.password);
      PrefUtils.setToken(loginModel.data?.token ?? '');
      PrefUtils.setId(loginModel.data?.user?.id.toString() ?? "");
      bool isFormComplete =
          (loginModel.data?.user?.isProfileComplete ?? 0) == 1;
      PrefUtils.setIsFormComplete(isFormComplete);
      //-----//
      String fcmToken = await FirebaseMessagingService.generateToken() ?? "";
      UserModel userModel = UserModel(
          id: loginModel.data?.user?.id.toString() ?? '', token: fcmToken);
      await FirebaseServices.updateUser(userModel);
      //-----//
      emit(LoginSuccessState(
          userId: loginModel.data?.user?.id ?? 0,
          isProfileComplete: isFormComplete));
    } catch (e) {
      print('ERROR=> ${e.toString()}');
      if (e.toString() == 'Account not approved') {
        emit(LoginUserNotApproved());
      } else {
        emit(LoginError(e.toString()));
      }
    }
  }

  FutureOr<void> _onLoginWithPhone(
      LoginWithPhoneEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 2));
      //TODO:Need to get profile complete status
      emit(const LoginSuccessState(userId: 0, isProfileComplete: true));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  FutureOr<void> _onLoginWithGoogle(
      LoginWithGoggleEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      UserCredential authResult = await FirebaseServices.signInWithGoogle();
      User? user = authResult.user;
      if (user != null) {
        LoginModel model = await _authRepository.socialLogin(
            email: user.email ?? '', source: LoginSource.google.name);
        PrefUtils.setUserName(user.displayName ?? '');
        PrefUtils.setUserEmail(user.email ?? '');
        PrefUtils.setUserProfile(user.photoURL ?? '');
        PrefUtils.setToken(model.data?.token ?? '');
        await setUserInFirebase(
            authResult, model.data?.user?.id?.toString() ?? '');
        UserRepository userRepository = UserRepository();
        UserModel profileModel = await userRepository.getUserProfile();
        emit(SocialLoginSuccessState(profileModel.isProfileComplete == 0));
      }
    } catch (e) {
      await FirebaseServices.googleSignIn.signOut();
      emit(LoginError(e.toString()));
    }
  }

  FutureOr<void> _onLoginWithAppleEvent(
      LoginWithAppleEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      UserCredential authResult = await FirebaseServices.signInWithApple();
      User? user = authResult.user;

      if (user != null) {
        LoginModel model = await _authRepository.socialLogin(
            email: user.email ?? '', source: LoginSource.apple.name);

        PrefUtils.setUserName(user.displayName ?? '');
        PrefUtils.setUserEmail(user.email ?? '');
        PrefUtils.setUserProfile(user.photoURL ?? '');
        PrefUtils.setToken(model.data?.token ?? '');

        await setUserInFirebase(
            authResult, model.data?.user?.id?.toString() ?? '');
        UserRepository userRepository = UserRepository();
        UserModel profileModel = await userRepository.getUserProfile();
        await setUserInFirebase(
            authResult, model.data?.user?.id?.toString() ?? '');
        emit(SocialLoginSuccessState(profileModel.isProfileComplete == 0));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> setUserInFirebase(
      UserCredential authResult, String userId) async {
    PrefUtils.setId(userId);
    User? user = authResult.user;
    String fcmToken = await FirebaseMessagingService.generateToken() ?? "";
    UserModel userModel = UserModel(
      id: userId,
      name: user?.displayName ?? '',
      email: user?.email ?? "",
      profileImg: user?.photoURL ?? "",
      token: fcmToken,
      role: PrefUtils.getRole(),
    );
    if (authResult.additionalUserInfo!.isNewUser) {
      await FirebaseServices.addUser(userModel);
    } else {
      await FirebaseServices.updateUser(userModel);
    }
  }
}

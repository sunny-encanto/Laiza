import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/login_model/login_model.dart';
import 'package:laiza/data/models/otp_verification_model/otp_verification_model.dart';
import 'package:laiza/data/models/signup_model/signup_model.dart';

import '../../../core/utils/api_constant.dart';
import '../../models/common_model/common_model.dart';
import '../../services/apiClient/dio_client.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'user_type': PrefUtils.getRole(),
    };
    try {
      Response response = await _apiClient.post(ApiConstant.login, data: data);
      if (response.statusCode == 200) {
        var responseData = await response.data;
        return LoginModel.fromJson(responseData);
      } else {
        var responseData = await response.data;
        return LoginModel.fromJson(responseData);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  Future<SignupModel> signUp({
    required String name,
    required String email,
    required String password,
    required String userType,
  }) async {
    try {
      Map<String, dynamic> userData = {
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': password,
        'user_type': userType,
      };
      Response response =
          await _apiClient.post(ApiConstant.singUp, data: userData);
      if (response.statusCode == 200) {
        var responseData = await response.data;
        return SignupModel.fromJson(responseData);
      } else {
        var responseData = await response.data;
        return SignupModel.fromJson(responseData);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception('Failed to Sign up');
    }
  }

  Future<OtpVerificationModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    Map<String, dynamic> data = {
      'email': email,
      'otp': otp,
    };
    try {
      Response response = await _apiClient
          .post(ApiConstant.verifyForgotPasswordOtp, data: data);
      if (response.statusCode == 200) {
        var responseData = await response.data;
        return OtpVerificationModel.fromJson(responseData);
      } else {
        var responseData = await response.data;
        return OtpVerificationModel.fromJson(responseData);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  Future<CommonModel> resendOtp({required String email}) async {
    Map<String, dynamic> data = {
      'email': email,
    };
    try {
      Response response =
          await _apiClient.post(ApiConstant.resendOtp, data: data);
      if (response.statusCode == 200) {
        var responseData = await response.data;
        return CommonModel.fromJson(responseData);
      } else {
        var responseData = await response.data;
        return CommonModel.fromJson(responseData);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  Future<CommonModel> forgotPassword({required String email}) async {
    Map<String, dynamic> data = {
      'email': email,
    };
    try {
      Response response =
          await _apiClient.post(ApiConstant.forgotPassword, data: data);
      if (response.statusCode == 200) {
        var responseData = await response.data;
        return CommonModel.fromJson(responseData);
      } else {
        var responseData = await response.data;
        return CommonModel.fromJson(responseData);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  Future<CommonModel> resetPassword(
      {required String email,
      required String confirmPassword,
      required String password}) async {
    Map<String, String> data = {
      'email': email,
      'password': password,
      'confirm_password': confirmPassword
    };
    try {
      Response response =
          await _apiClient.post(ApiConstant.resetPassword, data: data);
      if (response.statusCode == 200) {
        var responseData = await response.data;
        return CommonModel.fromJson(responseData);
      } else {
        var responseData = await response.data;
        return CommonModel.fromJson(responseData);
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      throw Exception('Failed to login');
    }
  }
}

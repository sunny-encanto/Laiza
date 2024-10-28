import 'package:dio/dio.dart';

import '../../services/apiClient/dio_client.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  Future<void> login() async {
    Response response = await _apiClient.post('/login');
    try {
      if (response.statusCode == 200) {
        // var loginData = await response.data;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  Future<void> signUp() async {
    Response response = await _apiClient.post('/signUp');
    try {
      if (response.statusCode == 200) {
        // var loginData = await response.data;
      } else {
        throw Exception('Failed to Sign up');
      }
    } catch (e) {
      throw Exception('Failed to Sign up');
    }
  }
}

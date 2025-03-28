import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../app_export.dart';
import '../errors/exceptions.dart';
import '../utils/api_constant.dart';

class ApiClient {
  late Dio _dio;

  // Constructor
  ApiClient({String? baseUrl}) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl ?? ApiConstant.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio = Dio(options);

    // Optional: Set up interceptors
    _dio.interceptors.addAll([
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          enabled: kDebugMode,
          maxWidth: 90),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Handle pre-request actions like adding auth tokens
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          // Handle successful response
          return handler.next(response); // Continue with the response
        },
        onError: (DioException error, handler) {
          // Handle errors
          debugPrint('Request failed: ${error.response?.statusCode}');
          return handler.next(error); // Continue with the error
        },
      )
    ]);
  }

  // GET request
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await _dio.get(path,
          queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      // Handle Dio exceptions
      throw handleException(e);
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }

  // POST request
  Future<Response> post(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.post(path, data: data, options: options);
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(String path,
      {Map<String, dynamic>? data, Options? options}) async {
    try {
      return await _dio.put(path, data: data, options: options);
    } catch (e) {
      throw Exception('PUT request failed: $e');
    }
  }

  // DELETE request
  Future<Response> delete(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.delete(path, data: data, options: options);
    } catch (e) {
      throw Exception('DELETE request failed: $e');
    }
  }

  // You can also add a method to set custom headers
  void setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  Exception handleException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      throw NoInternetException('Connection timeout. Please try again later.');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      throw NoInternetException('Receive timeout. Please try again later.');
    } else if (e.type == DioExceptionType.badResponse) {
      if (e.response?.statusCode == 404) {
        throw ServerException();
      }
      throw Exception('Server error: ${e.response?.statusCode}');
    } else if (e.type == DioExceptionType.cancel) {
      throw Exception('Request was cancelled.');
    } else if (e.type == DioExceptionType.connectionError) {
      Fluttertoast.showToast(
        msg: 'No Internet',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      throw Exception('No Internet Connection');
    } else {
      throw Exception('Unexpected error occurred: ${e.message}');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/common_model/common_model.dart';

import '../../../core/app_export.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../models/upcoming_stream_model/upcoming_stream_model.dart';

class LiveStreamRepository {
  final ApiClient _apiClient = ApiClient();

  Future<CommonModel> addStream({
    required String title,
    required String description,
    required String date,
    required String time,
    required List<String> productIds,
  }) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap({
        'title': title,
        'description': description,
        'date': date,
        'time': time,
        'product_id[]': productIds,
      });
      Response response =
          await _apiClient.post(ApiConstant.addStream, data: data);
      if (response.statusCode == 200) {
        CommonModel model = CommonModel.fromJson(response.data);
        return model;
      } else {
        CommonModel model = CommonModel.fromJson(response.data);
        return model;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during add stream', e.toString());
      throw Exception('Failed to add stream');
    }
  }

  Future<List<UpComingStream>> getAllStream() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient
          .get(ApiConstant.getAllStream, queryParameters: {'paginate': false});
      if (response.statusCode == 200) {
        UpComingStreamModel model = UpComingStreamModel.fromJson(response.data);
        return model.upComingStream;
      } else {
        UpComingStreamModel model = UpComingStreamModel.fromJson(response.data);
        return model.upComingStream;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get upcoming stream', e.toString());
      throw Exception('Failed to get upcoming stream');
    }
  }
}

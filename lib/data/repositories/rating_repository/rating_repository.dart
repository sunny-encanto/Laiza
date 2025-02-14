import 'package:dio/dio.dart';
import 'package:laiza/data/models/common_model/common_model.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/pref_utils.dart';

class RatingRepository {
  final ApiClient _apiClient = ApiClient();

  Future<CommonModel> addRating(
      {required int productId,
      required int rating,
      required String review}) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap(
          {'product_id': productId, 'rating': rating, 'review': review});
      Response response =
          await _apiClient.post(ApiConstant.addRating, data: data);
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
      Logger.log('Error during add rating', e.toString());
      throw Exception('Failed to add rating');
    }
  }
}

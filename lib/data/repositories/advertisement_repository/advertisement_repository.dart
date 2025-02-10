import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/advertisement_model/advertisement_model.dart';

import '../../../core/app_export.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';

class AdvertisementRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<Advertisement>> getAdvertisement() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient
          .get(ApiConstant.advertisement, queryParameters: {'paginate': false});

      if (response.statusCode == 200) {
        AdvertisementModel model = AdvertisementModel.fromJson(response.data);
        return model.advertisements;
      } else {
        AdvertisementModel model = AdvertisementModel.fromJson(response.data);
        return model.advertisements;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get advertisement', e.toString());
      throw Exception('Failed to get advertisement');
    }
  }
}

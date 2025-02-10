import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';

import '../../../core/app_export.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../models/faq_model/faq_model.dart';

class HelpCenterRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<FAQ>> getFAQ() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient
          .get(ApiConstant.fAQ, queryParameters: {'paginate': false});

      if (response.statusCode == 200) {
        FaqModel model = FaqModel.fromJson(response.data);
        return model.faqs;
      } else {
        FaqModel model = FaqModel.fromJson(response.data);
        return model.faqs;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get FAQ', e.toString());
      throw Exception('Failed to get FAQ');
    }
  }
}

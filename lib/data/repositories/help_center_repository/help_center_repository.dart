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

  Future<String> getPrivacyPolicy() async {
    try {
      Response response = await _apiClient.get(ApiConstant.getPrivacy);

      if (response.statusCode == 200) {
        return response.data['data'].toString();
      } else {
        return response.data['data'].toString();
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get privacy', e.toString());
      throw Exception('Failed to get privacy ');
    }
  }

  Future<String> getTermsAndCondition() async {
    try {
      Response response = await _apiClient.get(ApiConstant.termsAndConditions);

      if (response.statusCode == 200) {
        return response.data['data'].toString();
      } else {
        return response.data['data'].toString();
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get privacy', e.toString());
      throw Exception('Failed to get privacy ');
    }
  }

  Future<String> responsibleDisclosurePolicy() async {
    try {
      Response response =
          await _apiClient.get(ApiConstant.responsibleDisclosurePolicy);

      if (response.statusCode == 200) {
        return response.data['data'].toString();
      } else {
        return response.data['data'].toString();
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get privacy', e.toString());
      throw Exception('Failed to get privacy ');
    }
  }

  Future<String> antiPhishingPolicy() async {
    try {
      Response response = await _apiClient.get(ApiConstant.antiPhishingPolicy);

      if (response.statusCode == 200) {
        return response.data['data'].toString();
      } else {
        return response.data['data'].toString();
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get privacy', e.toString());
      throw Exception('Failed to get privacy ');
    }
  }

  Future<String> intellectualPropertyPolicy() async {
    try {
      Response response =
          await _apiClient.get(ApiConstant.intellectualPropertyPolicy);

      if (response.statusCode == 200) {
        return response.data['data'].toString();
      } else {
        return response.data['data'].toString();
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get privacy', e.toString());
      throw Exception('Failed to get privacy ');
    }
  }

  Future<String> refundReturnReplacementPolicy() async {
    try {
      Response response =
          await _apiClient.get(ApiConstant.refundReturnPropertyPolicy);

      if (response.statusCode == 200) {
        return response.data['data'].toString();
      } else {
        return response.data['data'].toString();
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get privacy', e.toString());
      throw Exception('Failed to get privacy ');
    }
  }

  Future<String> laiza_cancellation_refund_policy() async {
    try {
      Response response =
          await _apiClient.get(ApiConstant.laiza_cancellation_refund_policy);

      if (response.statusCode == 200) {
        return response.data['data'].toString();
      } else {
        return response.data['data'].toString();
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get privacy', e.toString());
      throw Exception('Failed to get privacy ');
    }
  }

  Future<String> third_party_functionalities() async {
    try {
      Response response =
          await _apiClient.get(ApiConstant.third_party_functionalities);

      if (response.statusCode == 200) {
        return response.data['data'].toString();
      } else {
        return response.data['data'].toString();
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get privacy', e.toString());
      throw Exception('Failed to get privacy ');
    }
  }
}

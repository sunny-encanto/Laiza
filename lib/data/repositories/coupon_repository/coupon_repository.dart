import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/coupon_detail_model/coupon_detail_model.dart';

import '../../../core/app_export.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';

class CouponRepository {
  final ApiClient _apiClient = ApiClient();

  Future<CouponDetail> getCouponDetail(String code) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient
          .post(ApiConstant.couponDetails, data: {'coupon_code': code});
      if (response.statusCode == 200) {
        CouponDetailsModel model = CouponDetailsModel.fromJson(response.data);
        return model.data;
      } else {
        CouponDetailsModel model = CouponDetailsModel.fromJson(response.data);
        return model.data;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get Coupon details', e.toString());
      throw Exception('Failed to Coupon details');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:laiza/data/models/common_model/common_model.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/pref_utils.dart';
import '../../models/cart_model/cart_model.dart';

class OrderRepository {
  final ApiClient _apiClient = ApiClient();

  Future<CommonModel> crateOrder(List<CartModel> selectedItems) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData formData = FormData();

      for (var item in selectedItems) {
        formData.fields.add(MapEntry('product_id[]', item.id.toString()));
        formData.fields.add(MapEntry('quantity[]', item.quantity.toString()));
      }
      Response response =
          await _apiClient.post(ApiConstant.createOrder, data: formData);
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
      Logger.log('Error during create order', e.toString());
      throw Exception('Failed to create order');
    }
  }
}

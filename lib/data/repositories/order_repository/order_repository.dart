import 'package:dio/dio.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/models/influencer_order_model/influencer_order_model.dart';
import 'package:laiza/data/models/my_orders_model/my_order_model.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/pref_utils.dart';
import '../../models/cart_model/cart_model.dart';

class OrderRepository {
  final ApiClient _apiClient = ApiClient();

  Future<CommonModel> crateOrder(
      List<CartModel> selectedItems, String paymentMode) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData formData = FormData();
      formData.fields.add(MapEntry('payment_status', paymentMode));
      for (var item in selectedItems) {
        formData.fields
            .add(MapEntry('inventory_id[]', item.inventoryId.toString()));
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

  Future<MyOrdersModel> getMyOrders() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient.get(ApiConstant.myOrder);
      if (response.statusCode == 200) {
        MyOrdersModel model = MyOrdersModel.fromJson(response.data);
        return model;
      } else {
        MyOrdersModel model = MyOrdersModel.fromJson(response.data);
        return model;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get my orders', e.toString());
      throw Exception('Failed to during get my orders');
    }
  }

  Future<InfluencerOrderModel> getInfluencerOrders(String year) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient
          .get(ApiConstant.influencerOrder, queryParameters: {'year': year});
      InfluencerOrderModel model = InfluencerOrderModel.fromJson(response.data);
      return model;
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get influencer order', e.toString());
      throw Exception('Failed to during get  influencer order');
    }
  }
}

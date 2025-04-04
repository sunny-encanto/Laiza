import 'package:dio/dio.dart';
import 'package:laiza/data/models/common_model/common_model.dart';

import '../../../core/app_export.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../../core/utils/pref_utils.dart';
import '../../models/wishlist_model/wishlist_model.dart';

class CartRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<WishlistData>> fetchCart() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.get(ApiConstant.cart);
      if (response.statusCode == 200) {
        WishlistModel wishlistModel = WishlistModel.fromJson(response.data);
        return wishlistModel.data;
      } else {
        WishlistModel wishlistModel = WishlistModel.fromJson(response.data);
        return wishlistModel.data;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get cart', e.toString());
      throw Exception('Failed to get cart');
    }
  }

  Future<CommonModel> addToCart(
      {required int id,
      required int quantity,
      required int inventoryId}) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap({
        'product_id': id,
        'quantity': quantity,
        'inventory_id': inventoryId
      });
      Response response =
          await _apiClient.post(ApiConstant.addToCart, data: data);
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
      Logger.log('Error during add to cart', e.toString());
      throw Exception('Failed to add to cart');
    }
  }

  Future<CommonModel> removeFromCart({required int cartId}) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response =
          await _apiClient.get("${ApiConstant.removerFromCart}/$cartId");
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
      Logger.log('Error during remove from cart', e.toString());
      throw Exception('Failed remove from cart');
    }
  }

  Future<CommonModel> updateCart(
      {required int cartId, required int quantity}) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap({"quantity": quantity});
      Response response = await _apiClient
          .post("${ApiConstant.updateCart}/$cartId", data: data);
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
      Logger.log('Error during update cart', e.toString());
      throw Exception('Failed to update cart');
    }
  }
}

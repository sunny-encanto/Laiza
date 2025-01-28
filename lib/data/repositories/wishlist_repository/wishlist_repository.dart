import 'package:dio/dio.dart';
import 'package:laiza/core/network/dio_client.dart';
import 'package:laiza/core/utils/api_constant.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/models/wishlist_model/wishlist_model.dart';

import '../../../core/app_export.dart';

class WishlistRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<WishlistData>> fetchWishList() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.get(ApiConstant.wishlist);
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
      Logger.log('Error during get wishlist', e.toString());
      throw Exception('Failed to get wishlist');
    }
  }

  Future<CommonModel> addToWishList(int productId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      FormData data = FormData.fromMap({'product_id': productId});
      Response response =
          await _apiClient.post(ApiConstant.addToWishList, data: data);
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
      Logger.log('Error during add Wishlist', e.toString());
      throw Exception('Failed to add wishlist');
    }
  }

  Future<CommonModel> removeFromWishList(int productId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response =
          await _apiClient.get("${ApiConstant.removerFromWishList}/$productId");
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
      Logger.log('Error during add Wishlist', e.toString());
      throw Exception('Failed to add wishlist');
    }
  }
}

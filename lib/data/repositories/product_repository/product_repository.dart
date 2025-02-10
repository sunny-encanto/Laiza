import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/models/product_model/product.dart';
import 'package:laiza/data/models/product_model/product_model.dart';

import '../../../core/app_export.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../models/product_model/all_product_model.dart';
import '../../models/reels_model/reel.dart';
import '../../models/reels_model/reels_model.dart';

class ProductRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<Product>> getAllProduct({required int page}) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response =
          await _apiClient.get(ApiConstant.allProduct, queryParameters: {
        'page': page,
        'paginate': true,
      });
      if (response.statusCode == 200) {
        AllProductModel model = AllProductModel.fromJson(response.data);
        return model.data.data;
      } else {
        AllProductModel model = AllProductModel.fromJson(response.data);
        return model.data.data;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get product', e.toString());
      throw Exception('Failed to get product');
    }
  }

  Future<List<Reel>> getAllInfluencerProduct() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response =
          await _apiClient.get(ApiConstant.allInfluencerProduct);
      if (response.statusCode == 200) {
        ReelModel model = ReelModel.fromJson(response.data);
        return model.reels;
      } else {
        ReelModel model = ReelModel.fromJson(response.data);
        return model.reels;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get allInfluencer Product ', e.toString());
      throw Exception('Failed to get allInfluencer Product');
    }
  }

  Future<Product> getProductDetail(int id) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response =
          await _apiClient.get("${ApiConstant.productDetails}/$id");
      if (response.statusCode == 200) {
        ProductModel model = ProductModel.fromJson(response.data);
        return model.data;
      } else {
        ProductModel model = ProductModel.fromJson(response.data);
        return model.data;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get details', e.toString());
      throw Exception('Failed to get details');
    }
  }

  Future<CommonModel> askForPromotion(int productId) async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Map<String, dynamic> data = {
        'product_id': productId,
        'influencer_id': PrefUtils.getId()
      };
      Response response =
          await _apiClient.post(ApiConstant.askPromotion, data: data);
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
      Logger.log('Error during  get details', e.toString());
      throw Exception('Failed to get details');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/product_model/product.dart';
import 'package:laiza/data/models/product_model/product_model.dart';

import '../../../core/app_export.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../models/product_model/all_product_model.dart';

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
}

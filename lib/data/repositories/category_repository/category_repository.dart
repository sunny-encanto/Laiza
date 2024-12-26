import 'package:dio/dio.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/category_model/Category.dart';
import 'package:laiza/data/models/category_model/Category_model.dart';

import '../../../core/app_export.dart';
import '../../../core/utils/api_constant.dart';
import '../../services/apiClient/dio_client.dart';

class CategoryRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<Category>> getCategories() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});
      Response response = await _apiClient.get(ApiConstant.getCategories);
      if (response.statusCode == 200) {
        CategoryModel model = CategoryModel.fromJson(response.data);
        return model.category ?? <Category>[];
      } else {
        CategoryModel model = CategoryModel.fromJson(response.data);
        return model.category ?? <Category>[];
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during  get categories', e.toString());
      throw Exception('Failed to get get categories');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:laiza/data/models/trending_items_model/trending_items_model.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/utils/api_constant.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/pref_utils.dart';

class PostRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<TrendingItems>> getTrendingItems() async {
    try {
      _apiClient
          .setHeaders({'Authorization': 'Bearer ${PrefUtils.getToken()}'});

      Response response = await _apiClient.get(ApiConstant.trendingItems);
      if (response.statusCode == 200) {
        TrendingItemsModel model = TrendingItemsModel.fromJson(response.data);
        return model.items;
      } else {
        TrendingItemsModel model = TrendingItemsModel.fromJson(response.data);
        return model.items;
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Unknown error';
      throw message;
    } catch (e) {
      Logger.log('Error during get trending items', e.toString());
      throw Exception('Failed to get trending items');
    }
  }
}

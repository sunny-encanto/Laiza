import 'package:dio/dio.dart';
import 'package:laiza/data/models/wishlist_model/wishlist_model.dart';
import 'package:laiza/data/services/apiClient/dio_client.dart';

class WishlistRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<Wishlist>> fetchWishList() async {
    Response response = await _apiClient.get('/c/86a9-b5e0-48dc-ae5f');
    try {
      if (response.statusCode == 200) {
        WishlistModel wishlistModel = WishlistModel.fromJson(response.data);
        return wishlistModel.wishlist;
      } else {
        throw Exception('Failed to fetch Wishlist');
      }
    } catch (e) {
      throw Exception('Failed to fetch Wishlist');
    }
  }
}

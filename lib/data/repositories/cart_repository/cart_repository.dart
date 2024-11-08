import 'package:dio/dio.dart';

import '../../models/cart_model/cart_model.dart';
import '../../services/apiClient/dio_client.dart';

class CartRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<CartModel>> fetchCart() async {
    Response response = await _apiClient.get('/carts');
    try {
      if (response.statusCode == 200) {
        List<CartModel> cartList = <CartModel>[];
        List productList = [];
        productList.addAll(response.data['carts'][1]['products']);
        cartList = productList
            .map((e) => CartModel(
                  id: e['id'],
                  url: e['thumbnail'],
                  price: e['price'],
                  quantity: e['quantity'],
                  name: e['title'],
                  isSelected: false,
                ))
            .toList();
        return cartList;
      } else {
        throw Exception('Failed to fetch Cart');
      }
    } catch (e) {
      throw Exception('Failed to fetch Cart');
    }
  }
}

import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final int cartId;
  final int id;
  final String url;
  final double price;
  final int quantity;
  final String name;
  final bool isSelected;
  final int inventoryId;

  const CartModel({
    required this.cartId,
    required this.id,
    required this.url,
    required this.price,
    required this.quantity,
    required this.name,
    required this.isSelected,
    required this.inventoryId,
  });

  CartModel copyWith({
    int? quantity,
    bool? isSelected,
  }) =>
      CartModel(
        cartId: cartId,
        id: id,
        url: url,
        price: price,
        quantity: quantity ?? this.quantity,
        name: name,
        isSelected: isSelected ?? this.isSelected,
        inventoryId: inventoryId,
      );

  @override
  List<Object?> get props =>
      [id, url, price, quantity, name, isSelected, cartId, inventoryId];
}

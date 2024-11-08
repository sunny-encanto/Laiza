import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final int id;
  final String url;
  final double price;
  final int quantity;
  final String name;
  final bool isSelected;

  const CartModel({
    required this.id,
    required this.url,
    required this.price,
    required this.quantity,
    required this.name,
    required this.isSelected,
  });

  CartModel copyWith({
    int? quantity,
    bool? isSelected,
  }) =>
      CartModel(
        id: id,
        url: url,
        price: price,
        quantity: quantity ?? this.quantity,
        name: name,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  List<Object?> get props => [id, url, price, quantity, name, isSelected];
}

List<CartModel> cartItemsList = <CartModel>[
  const CartModel(
    id: 1,
    name: 'Classic  Sneakers – Minimalist Design, Maximum Comfort',
    url:
        'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
    price: 123,
    quantity: 1,
    isSelected: false,
  ),
  const CartModel(
    id: 2,
    name: 'Classic  Sneakers – Minimalist Design, Maximum Comfort',
    url:
        'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
    price: 123,
    quantity: 1,
    isSelected: false,
  ),
  const CartModel(
    id: 3,
    name: 'Classic  Sneakers – Minimalist Design, Maximum Comfort',
    url:
        'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
    price: 123,
    quantity: 1,
    isSelected: false,
  ),
];

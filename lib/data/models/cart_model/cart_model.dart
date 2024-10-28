class CartModel {
  final int id;
  final String url;
  double price;
  int quantity;
  final String name;
  bool isSelected;
  CartModel({
    required this.id,
    required this.url,
    required this.price,
    this.quantity = 1,
    required this.name,
    this.isSelected = false,
  });
}

List<CartModel> cartItemsList = <CartModel>[
  CartModel(
    id: 1,
    name: 'Classic  Sneakers – Minimalist Design, Maximum Comfort',
    url:
        'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
    price: 123,
    quantity: 1,
  ),
  CartModel(
    id: 2,
    name: 'Classic  Sneakers – Minimalist Design, Maximum Comfort',
    url:
        'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
    price: 123,
    quantity: 1,
  ),
  CartModel(
    id: 3,
    name: 'Classic  Sneakers – Minimalist Design, Maximum Comfort',
    url:
        'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
    price: 123,
    quantity: 1,
  ),
];

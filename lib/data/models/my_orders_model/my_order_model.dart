import 'package:laiza/data/models/product_model/product.dart';

class MyOrdersModel {
  bool success;
  List<Order> orders;
  String message;

  MyOrdersModel({
    required this.success,
    required this.orders,
    required this.message,
  });

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
        success: json["success"],
        orders: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(orders.map((x) => x.toJson())),
        "message": message,
      };
}

class Order {
  int id;
  int userId;
  String orderNumber;
  String totalPrice;
  String discount;
  String finalPrice;
  String couponCode;
  String status;
  String paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderItem> items;
  ProductUser users;

  Order({
    required this.id,
    required this.userId,
    required this.orderNumber,
    required this.totalPrice,
    required this.discount,
    required this.finalPrice,
    required this.couponCode,
    required this.status,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.users,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        orderNumber: json["order_number"],
        totalPrice: json["total_price"],
        discount: json["discount"],
        finalPrice: json["final_price"],
        couponCode: json["coupon_code"] ?? '',
        status: json["status"],
        paymentStatus: json["payment_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        items: List<OrderItem>.from(
            json["items"].map((x) => OrderItem.fromJson(x))),
        users: ProductUser.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_number": orderNumber,
        "total_price": totalPrice,
        "discount": discount,
        "final_price": finalPrice,
        "coupon_code": couponCode,
        "status": status,
        "payment_status": paymentStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "users": users.toJson(),
      };
}

class OrderItem {
  int id;
  int orderId;
  int productId;
  int quantity;
  String price;
  int gst;
  DateTime createdAt;
  DateTime updatedAt;

  Product product;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.gst,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"] ?? 0,
        orderId: json["order_id"] ?? 0,
        productId: json["product_id"] ?? 0,
        quantity: json["quantity"] ?? 0,
        price: json["price"],
        gst: json["gst"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "gst": gst,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        // "product": product.toJson(),
      };
}

// //
class Product {
  int id;
  int userId;
  String productName;
  String sku;
  String productImage;
  String description;
  String hashtags;
  int category;

  String hsnCode;

  int gst;
  String finalPrice;

  Product({
    required this.id,
    required this.userId,
    required this.productName,
    required this.sku,
    required this.productImage,
    required this.description,
    required this.hashtags,
    required this.category,
    required this.hsnCode,
    required this.gst,
    required this.finalPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        userId: json["user_id"],
        productName: json["product_name"],
        sku: json["sku"],
        productImage: json["product_image"],
        description: json["description"],
        hashtags: json["hashtags"],
        category: json["category"],
        hsnCode: json["hsn_code"],
        gst: json["gst"],
        finalPrice: json["final_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_name": productName,
        "sku": sku,
        "product_image": productImage,
        "description": description,
        "hashtags": hashtags,
        "category": category,
        "gst": gst,
        "final_price": finalPrice,
      };
}

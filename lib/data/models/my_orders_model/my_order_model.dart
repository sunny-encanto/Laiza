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
  dynamic couponCode;
  String status;
  String paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderItem> items;
  Users users;

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
        couponCode: json["coupon_code"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        items: List<OrderItem>.from(
            json["items"].map((x) => OrderItem.fromJson(x))),
        users: Users.fromJson(json["users"]),
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
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        gst: json["gst"],
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
        "product": product.toJson(),
      };
}

class Product {
  int id;
  int userId;
  String productName;
  String sku;
  String productImage;
  String description;
  String hashtags;
  int category;
  int? subcategory1;
  int? subcategory2;
  int? subcategory3;
  dynamic subcategory4;
  dynamic subcategory5;
  dynamic subcategory6;
  int stockQuantity;
  String hsnCode;
  String price;
  int productDiscount;
  String discountPrice;
  int gst;
  String finalPrice;
  List<String> availableSize;
  List<String> availableColor;
  dynamic couponDiscount;
  List<String> features;
  int promotionalStatus;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.id,
    required this.userId,
    required this.productName,
    required this.sku,
    required this.productImage,
    required this.description,
    required this.hashtags,
    required this.category,
    required this.subcategory1,
    required this.subcategory2,
    required this.subcategory3,
    required this.subcategory4,
    required this.subcategory5,
    required this.subcategory6,
    required this.stockQuantity,
    required this.hsnCode,
    required this.price,
    required this.productDiscount,
    required this.discountPrice,
    required this.gst,
    required this.finalPrice,
    required this.availableSize,
    required this.availableColor,
    required this.couponDiscount,
    required this.features,
    required this.promotionalStatus,
    required this.createdAt,
    required this.updatedAt,
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
        subcategory1: json["subcategory_1"],
        subcategory2: json["subcategory_2"],
        subcategory3: json["subcategory_3"],
        subcategory4: json["subcategory_4"],
        subcategory5: json["subcategory_5"],
        subcategory6: json["subcategory_6"],
        stockQuantity: json["stock_quantity"],
        hsnCode: json["hsn_code"],
        price: json["price"],
        productDiscount: json["product_discount"],
        discountPrice: json["discount_price"],
        gst: json["gst"],
        finalPrice: json["final_price"],
        availableSize: List<String>.from(json["available_size"].map((x) => x)),
        availableColor:
            List<String>.from(json["available_color"].map((x) => x)),
        couponDiscount: json["coupon_discount"],
        features: List<String>.from(json["features"].map((x) => x)),
        promotionalStatus: json["promotional_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "subcategory_1": subcategory1,
        "subcategory_2": subcategory2,
        "subcategory_3": subcategory3,
        "subcategory_4": subcategory4,
        "subcategory_5": subcategory5,
        "subcategory_6": subcategory6,
        "stock_quantity": stockQuantity,
        "hsn_code": hsnCode,
        "price": price,
        "product_discount": productDiscount,
        "discount_price": discountPrice,
        "gst": gst,
        "final_price": finalPrice,
        "available_size": List<dynamic>.from(availableSize.map((x) => x)),
        "available_color": List<dynamic>.from(availableColor.map((x) => x)),
        "coupon_discount": couponDiscount,
        "features": List<dynamic>.from(features.map((x) => x)),
        "promotional_status": promotionalStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Users {
  int id;
  String name;

  Users({
    required this.id,
    required this.name,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

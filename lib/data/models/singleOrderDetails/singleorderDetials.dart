import '../my_orders_model/my_order_model.dart';

class SingleOrderDetailsModel {
  bool success;
  Data data;
  String message;

  SingleOrderDetailsModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SingleOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      SingleOrderDetailsModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  int id;
  int userId;
  String orderNumber;
  String totalPrice;
  String discount;
  String finalPrice;
  dynamic couponCode;
  String status;
  String paymentStatus;
  dynamic shippingCharges;
  dynamic courierName;
  dynamic trackingId;
  dynamic labelUrl;
  dynamic shipmentId;
  dynamic routingCode;
  dynamic transporterId;
  DateTime createdAt;
  DateTime updatedAt;
  int totalProducts;
  List<Item> items;
  Users users;

  Data({
    required this.id,
    required this.userId,
    required this.orderNumber,
    required this.totalPrice,
    required this.discount,
    required this.finalPrice,
    required this.couponCode,
    required this.status,
    required this.paymentStatus,
    required this.shippingCharges,
    required this.courierName,
    required this.trackingId,
    required this.labelUrl,
    required this.shipmentId,
    required this.routingCode,
    required this.transporterId,
    required this.createdAt,
    required this.updatedAt,
    required this.totalProducts,
    required this.items,
    required this.users,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        orderNumber: json["order_number"],
        totalPrice: json["total_price"],
        discount: json["discount"],
        finalPrice: json["final_price"],
        couponCode: json["coupon_code"] ?? '',
        status: json["status"],
        paymentStatus: json["payment_status"],
        shippingCharges: json["shipping_charges"] ?? '',
        courierName: json["courier_name"] ?? '',
        trackingId: json["tracking_id"] ?? '',
        labelUrl: json["label_url"] ?? '',
        shipmentId: json["shipment_id"] ?? '',
        routingCode: json["routing_code"] ?? '',
        transporterId: json["transporter_id"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        totalProducts: json["total_products"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
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
        "shipping_charges": shippingCharges,
        "courier_name": courierName,
        "tracking_id": trackingId,
        "label_url": labelUrl,
        "shipment_id": shipmentId,
        "routing_code": routingCode,
        "transporter_id": transporterId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "total_products": totalProducts,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "users": users.toJson(),
      };
}

class Item {
  int id;
  int orderId;
  int productId;
  int quantity;
  String price;
  int gst;
  int inventoryId;
  String size;
  String color;
  dynamic platformCommission;
  dynamic sellerEarning;
  dynamic influencerEarning;
  DateTime createdAt;
  DateTime updatedAt;
  Product product;

  Item({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.gst,
    required this.inventoryId,
    required this.size,
    required this.color,
    required this.platformCommission,
    required this.sellerEarning,
    required this.influencerEarning,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        gst: json["gst"],
        inventoryId: json["inventory_id"],
        size: json["size"],
        color: json["color"],
        platformCommission: json["platform_commission"],
        sellerEarning: json["seller_earning"],
        influencerEarning: json["influencer_earning"],
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
        "inventory_id": inventoryId,
        "size": size,
        "color": color,
        "platform_commission": platformCommission,
        "seller_earning": sellerEarning,
        "influencer_earning": influencerEarning,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product.toJson(),
      };
}

class Users {
  int id;
  String name;
  String phoneNumber;

  Users({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
      };
}

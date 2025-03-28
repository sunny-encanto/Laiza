class InfluencerOrderModel {
  List<InfluencerOrder> influencerOrder;
  List<Graph> graph;
  String message;
  int status;
  bool error;

  InfluencerOrderModel({
    required this.influencerOrder,
    required this.graph,
    required this.message,
    required this.status,
    required this.error,
  });

  factory InfluencerOrderModel.fromJson(Map<String, dynamic> json) =>
      InfluencerOrderModel(
        influencerOrder: List<InfluencerOrder>.from(
            json["data"].map((x) => InfluencerOrder.fromJson(x))),
        graph: List<Graph>.from(json["graph"].map((x) => Graph.fromJson(x))),
        message: json["message"],
        status: json["status"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(influencerOrder.map((x) => x.toJson())),
        "graph": List<dynamic>.from(graph.map((x) => x.toJson())),
        "message": message,
        "status": status,
        "error": error,
      };
}

class InfluencerOrder {
  int id;
  int productId;
  int influencerId;
  String amount;
  String name;
  String phoneNumber;
  String pincode;
  int city;
  int state;
  int country;
  String houseNo;
  String area;
  String landmark;
  String status;
  String paymentStatus;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  InfluencerProduct product;

  // UserModel user;

  InfluencerOrder({
    required this.id,
    required this.productId,
    required this.influencerId,
    required this.amount,
    required this.name,
    required this.phoneNumber,
    required this.pincode,
    required this.city,
    required this.state,
    required this.country,
    required this.houseNo,
    required this.area,
    required this.landmark,
    required this.status,
    required this.paymentStatus,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    // required this.user,
  });

  factory InfluencerOrder.fromJson(Map<String, dynamic> json) =>
      InfluencerOrder(
        id: json["id"],
        productId: json["product_id"] ?? 0,
        influencerId: json["influencer_id"] ?? 0,
        amount: json["amount"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        pincode: json["pincode"],
        city: json["city"] ?? 0,
        state: json["state"] ?? 0,
        country: json["country"] ?? 0,
        houseNo: json["house_no"],
        area: json["area"],
        landmark: json["landmark"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        userId: json["user_id"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: InfluencerProduct.fromJson(json["product"]),
        // user: UserModel.fromJson(
        //   json: json["user"],
        //   id: (json["user"]['id']).toString(),
        // ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "influencer_id": influencerId,
        "amount": amount,
        "name": name,
        "phone_number": phoneNumber,
        "pincode": pincode,
        "city": city,
        "state": state,
        "country": country,
        "house_no": houseNo,
        "area": area,
        "landmark": landmark,
        "status": status,
        "payment_status": paymentStatus,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product.toJson(),
        // "user": user.toJson(),
      };
}

class InfluencerProduct {
  int id;
  int userId;
  String productName;
  String sku;
  String productImage;
  String description;
  String hashtags;
  String brand;
  int category;
  int subcategory1;
  int subcategory2;
  int? subcategory3;
  dynamic subcategory4;
  dynamic subcategory5;
  dynamic subcategory6;
  String hsnCode;
  List<String> features;
  String price;
  int gst;
  String totalWithGst;
  String laizaCommission;
  String commissionGstAmount;
  String laizaTotal;
  String finalPrice;
  int promotionalStatus;
  int isApprove;
  int totalQuantity;
  DateTime createdAt;
  DateTime updatedAt;

  InfluencerProduct({
    required this.id,
    required this.userId,
    required this.productName,
    required this.sku,
    required this.productImage,
    required this.description,
    required this.hashtags,
    required this.brand,
    required this.category,
    required this.subcategory1,
    required this.subcategory2,
    required this.subcategory3,
    required this.subcategory4,
    required this.subcategory5,
    required this.subcategory6,
    required this.hsnCode,
    required this.features,
    required this.price,
    required this.gst,
    required this.totalWithGst,
    required this.laizaCommission,
    required this.commissionGstAmount,
    required this.laizaTotal,
    required this.finalPrice,
    required this.promotionalStatus,
    required this.isApprove,
    required this.totalQuantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InfluencerProduct.fromJson(Map<String, dynamic> json) =>
      InfluencerProduct(
        id: json["id"],
        userId: json["user_id"],
        productName: json["product_name"],
        sku: json["sku"],
        productImage: json["product_image"],
        description: json["description"],
        hashtags: json["hashtags"],
        brand: json["brand"],
        category: json["category"],
        subcategory1: json["subcategory_1"],
        subcategory2: json["subcategory_2"],
        subcategory3: json["subcategory_3"],
        subcategory4: json["subcategory_4"],
        subcategory5: json["subcategory_5"],
        subcategory6: json["subcategory_6"],
        hsnCode: json["hsn_code"],
        features: List<String>.from(json["features"].map((x) => x)),
        price: json["price"],
        gst: json["gst"],
        totalWithGst: json["total_with_gst"],
        laizaCommission: json["laiza_commission"],
        commissionGstAmount: json["commission_gst_amount"],
        laizaTotal: json["laiza_total"],
        finalPrice: json["final_price"],
        promotionalStatus: json["promotional_status"],
        isApprove: json["is_approve"],
        totalQuantity: json["total_quantity"],
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
        "brand": brand,
        "category": category,
        "subcategory_1": subcategory1,
        "subcategory_2": subcategory2,
        "subcategory_3": subcategory3,
        "subcategory_4": subcategory4,
        "subcategory_5": subcategory5,
        "subcategory_6": subcategory6,
        "hsn_code": hsnCode,
        "features": List<dynamic>.from(features.map((x) => x)),
        "price": price,
        "gst": gst,
        "total_with_gst": totalWithGst,
        "laiza_commission": laizaCommission,
        "commission_gst_amount": commissionGstAmount,
        "laiza_total": laizaTotal,
        "final_price": finalPrice,
        "promotional_status": promotionalStatus,
        "is_approve": isApprove,
        "total_quantity": totalQuantity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Graph {
  String date;
  int totalOrders;
  int totalAmount;

  Graph({
    required this.date,
    required this.totalOrders,
    required this.totalAmount,
  });

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        date: json["date"],
        totalOrders: json["total_orders"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "total_orders": totalOrders,
        "total_amount": totalAmount,
      };
}

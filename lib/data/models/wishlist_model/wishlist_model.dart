class WishlistModel {
  String message;
  int status;
  bool error;
  List<WishlistData> data;

  WishlistModel({
    required this.message,
    required this.status,
    required this.error,
    required this.data,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        data: List<WishlistData>.from(
            json["data"].map((x) => WishlistData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WishlistData {
  int id;
  int userId;
  int productId;
  DateTime createdAt;
  DateTime updatedAt;
  WishListProduct product;
  int quantity;

  WishlistData({
    required this.id,
    required this.userId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.quantity,
  });

  factory WishlistData.fromJson(Map<String, dynamic> json) => WishlistData(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        quantity: json["quantity"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: WishListProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product.toJson(),
      };
}

class WishListProduct {
  int id;
  String productName;
  String price;
  List<Image> images;

  WishListProduct({
    required this.id,
    required this.productName,
    required this.price,
    required this.images,
  });

  factory WishListProduct.fromJson(Map<String, dynamic> json) =>
      WishListProduct(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  int id;
  int productId;
  String imagePath;

  Image({
    required this.id,
    required this.productId,
    required this.imagePath,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["product_id"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "image_path": imagePath,
      };
}

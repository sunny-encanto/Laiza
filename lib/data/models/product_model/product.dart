import 'package:laiza/data/models/product_model/video.dart';

import '../category_model/category.dart';
import 'coupon.dart';
import 'product_image.dart';

class Product {
  int id;
  int userId;
  String productName;
  String description;
  String hashtags;

  ProductCategory category;

  // Category subcategory;
  String price;
  int stockQuantity;
  List<String> availableSize;
  List<String> availableColor;
  List<String> couponDiscount;
  List<String> features;
  int promotionalStatus;
  DateTime createdAt;
  DateTime updatedAt;
  List<Coupon> coupons;
  List<Image> images;
  List<Video> videos;
  ProductUser user;
  bool isAddedToWishlist;

  Product(
      {required this.id,
      required this.userId,
      required this.productName,
      required this.description,
      required this.hashtags,
      required this.category,
      // required this.subcategory,
      required this.price,
      required this.stockQuantity,
      required this.availableSize,
      required this.availableColor,
      required this.couponDiscount,
      required this.features,
      required this.promotionalStatus,
      required this.createdAt,
      required this.updatedAt,
      required this.coupons,
      required this.images,
      required this.videos,
      required this.user,
      required this.isAddedToWishlist});

  Product copyWith({bool? isAddedToWishlist, int? promotionalStatus}) {
    return Product(
      id: id,
      userId: userId,
      productName: productName,
      description: description,
      hashtags: hashtags,
      price: price,
      stockQuantity: stockQuantity,
      availableSize: availableSize,
      availableColor: availableColor,
      couponDiscount: couponDiscount,
      features: features,
      promotionalStatus: promotionalStatus ?? this.promotionalStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
      coupons: coupons,
      images: images,
      videos: videos,
      user: user,
      category: category,
      isAddedToWishlist: isAddedToWishlist ?? this.isAddedToWishlist,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        userId: json["user_id"],
        productName: json["product_name"],
        description: json["description"],
        hashtags: json["hashtags"],
        category: ProductCategory.fromJson(json["category"]),
        // subcategory: Category.fromJson(json["subcategory"]),
        price: json["price"],
        stockQuantity: json["stock_quantity"],
        availableSize: List<String>.from(json["available_size"].map((x) => x)),
        availableColor: json["available_color"] == null
            ? <String>[]
            : List<String>.from(json["available_color"].map((x) => x)),
        couponDiscount: json["coupon_discount"] == null
            ? <String>[]
            : List<String>.from(json["coupon_discount"].map((x) => x)),
        features: List<String>.from(json["features"].map((x) => x)),
        promotionalStatus: json["promotional_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        coupons: json["coupons"] == null
            ? <Coupon>[]
            : List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
        images: json["images"] == null
            ? <Image>[]
            : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        videos: json["videos"] == null
            ? <Video>[]
            : List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        user: ProductUser.fromJson(json["users"]),
        isAddedToWishlist: json['isAddedToWishlist'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_name": productName,
        "description": description,
        "hashtags": hashtags,
        "category": category.toJson(),
        // "subcategory": subcategory.toJson(),
        "price": price,
        "stock_quantity": stockQuantity,
        "available_size": List<dynamic>.from(availableSize.map((x) => x)),
        "available_color": List<dynamic>.from(availableColor.map((x) => x)),
        "coupon_discount": couponDiscount,
        "features": List<dynamic>.from(features.map((x) => x)),
        "promotional_status": promotionalStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "coupons": List<dynamic>.from(coupons.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "users": user.toJson(),
      };
}

class ProductUser {
  num? id;
  String? name;

  ProductUser({
    this.id,
    this.name,
  });

  factory ProductUser.fromJson(dynamic json) => ProductUser(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;

    return map;
  }
}

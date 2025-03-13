import 'package:laiza/data/models/product_model/video.dart';

import '../category_model/category.dart';
import '../rating_model/rating_model.dart';
import 'coupon.dart';
import 'product_image.dart';

class Product {
  int id;
  int userId;
  String productName;
  String description;
  String hashtags;
  ProductCategory category;
  int discount;

  // Category subcategory;
  String price;
  String finalPrice;
  int stockQuantity;
  List<String> availableSize;
  List<String> availableColor;
  List<String> couponDiscount;
  List<String> features;
  int promotionalStatus;

  List<Coupon> coupons;
  List<Image> images;
  String productImage;
  List<Video> videos;
  ProductUser user;
  bool isAddedToWishlist;
  bool isAsked;
  ProductAdditionalInfo? additionalInfo;
  List<Rating> ratings;
  num averageRating;
  num totalRatings;

  Product({
    required this.id,
    required this.userId,
    required this.productName,
    required this.description,
    required this.hashtags,
    required this.category,
    // required this.subcategory,
    required this.price,
    required this.finalPrice,
    required this.stockQuantity,
    required this.availableSize,
    required this.availableColor,
    required this.couponDiscount,
    required this.features,
    required this.promotionalStatus,
    required this.coupons,
    required this.images,
    required this.videos,
    required this.user,
    required this.isAddedToWishlist,
    required this.isAsked,
    this.additionalInfo,
    required this.ratings,
    required this.averageRating,
    required this.totalRatings,
    required this.discount,
    required this.productImage,
  });

  Product copyWith({bool? isAddedToWishlist, bool? isAsked}) {
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
        promotionalStatus: promotionalStatus,
        coupons: coupons,
        images: images,
        videos: videos,
        user: user,
        category: category,
        isAddedToWishlist: isAddedToWishlist ?? this.isAddedToWishlist,
        isAsked: isAsked ?? this.isAsked,
        additionalInfo: additionalInfo,
        ratings: ratings,
        averageRating: averageRating,
        totalRatings: totalRatings,
        finalPrice: finalPrice,
        discount: discount,
        productImage: productImage);
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      userId: json["user_id"] ?? 0,
      productName: json["product_name"] ?? "",
      productImage: json["product_image"] ?? "",
      description: json["description"] ?? "",
      hashtags: json["hashtags"] ?? "",
      category: json["category"] == null
          ? ProductCategory(name: '', id: 0)
          : ProductCategory.fromJson(json["category"]),
      // subcategory: Category.fromJson(json["subcategory"]),
      price: json["price"],
      finalPrice: json["final_price"] ?? "",
      stockQuantity: json["stock_quantity"] ?? 0,
      availableSize: json["available_size"] == null
          ? <String>[]
          : List<String>.from(json["available_size"].map((x) => x)),
      availableColor: json["available_color"] == null
          ? <String>[]
          : List<String>.from(json["available_color"].map((x) => x)),
      couponDiscount: json["coupon_discount"] == null
          ? <String>[]
          : List<String>.from(json["coupon_discount"].map((x) => x)),
      features: json["features"] == null
          ? <String>[]
          : List<String>.from(json["features"].map((x) => x)),
      promotionalStatus: json["promotional_status"] ?? 0,
      coupons: json["coupons"] == null
          ? <Coupon>[]
          : List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
      images: json["images"] == null
          ? <Image>[]
          : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      videos: json["videos"] == null
          ? <Video>[]
          : List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
      user: json["users"] == null
          ? ProductUser(id: 0, name: '')
          : ProductUser.fromJson(json["users"]),
      isAddedToWishlist: json['is_wishlist'] ?? false,
      isAsked: json['is_asked'] ?? false,
      ratings: json["ratings"] == null
          ? <Rating>[]
          : List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
      averageRating: json["average_rating"] ?? 0,
      totalRatings: json["total_ratings"] ?? 0,
      discount: json["product_discount"] ?? 0,
      additionalInfo: json['additional_info'] == null
          ? null
          : ProductAdditionalInfo.fromJson(json['additional_info']));

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_name": productName,
        "description": description,
        "hashtags": hashtags,
        "category": category.toJson(),
        "product_image": productImage,
        "price": price,
        "final_price": finalPrice,
        "stock_quantity": stockQuantity,
        "available_size": List<dynamic>.from(availableSize.map((x) => x)),
        "available_color": List<dynamic>.from(availableColor.map((x) => x)),
        "coupon_discount": couponDiscount,
        "features": List<dynamic>.from(features.map((x) => x)),
        "promotional_status": promotionalStatus,
        "coupons": List<dynamic>.from(coupons.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "users": user.toJson(),
        'additional_info': additionalInfo?.toJson(),
        "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
        "average_rating": averageRating,
        "total_ratings": totalRatings,
        "product_discount": discount,
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

class ProductAdditionalInfo {
  int id;
  int productId;
  String manufacture;
  String packer;
  String importer;
  String itemWeight;
  String itemDimensions;
  String netQuantity;
  String includedComponents;
  String genericName;

  ProductAdditionalInfo({
    required this.id,
    required this.productId,
    required this.manufacture,
    required this.packer,
    required this.importer,
    required this.itemWeight,
    required this.itemDimensions,
    required this.netQuantity,
    required this.includedComponents,
    required this.genericName,
  });

  factory ProductAdditionalInfo.fromJson(Map<String, dynamic> json) =>
      ProductAdditionalInfo(
        id: json["id"],
        productId: json["product_id"],
        manufacture: json["manufacture"] ?? '',
        packer: json["packer"] ?? '',
        importer: json["importer"] ?? '',
        itemWeight: json["item_weight"] ?? '',
        itemDimensions: json["item_dimensions"] ?? '',
        netQuantity: json["net_quantity"] ?? '',
        includedComponents: json["included_components"] ?? '',
        genericName: json["generic_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "manufacture": manufacture,
        "packer": packer,
        "importer": importer,
        "item_weight": itemWeight,
        "item_dimensions": itemDimensions,
        "net_quantity": netQuantity,
        "included_components": includedComponents,
        "generic_name": genericName,
      };
}

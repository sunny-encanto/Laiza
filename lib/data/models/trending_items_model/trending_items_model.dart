import '../reels_model/reel.dart';

class TrendingItemsModel {
  String message;
  int status;
  bool error;
  List<TrendingItems> items;

  TrendingItemsModel({
    required this.message,
    required this.status,
    required this.error,
    required this.items,
  });

  factory TrendingItemsModel.fromJson(Map<String, dynamic> json) =>
      TrendingItemsModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        items: List<TrendingItems>.from(
            json["data"].map((x) => TrendingItems.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class TrendingItems {
  int id;
  TrendingItemType type;
  String image;
  String? reelPath;
  int isLike;
  int isFollow;
  List<ReelProduct> product;
  String userName;
  String userImage;
  int userId;

  TrendingItems({
    required this.id,
    required this.type,
    required this.image,
    required this.reelPath,
    required this.isLike,
    required this.isFollow,
    required this.product,
    required this.userName,
    required this.userImage,
    required this.userId,
  });

  TrendingItems copyWith({int? isLike, int? isFollow}) => TrendingItems(
        id: id,
        type: type,
        image: image,
        reelPath: reelPath,
        isLike: isLike ?? this.isLike,
        isFollow: isFollow ?? this.isFollow,
        product: product,
        userName: userName,
        userImage: userImage,
        userId: userId,
      );

  factory TrendingItems.fromJson(Map<String, dynamic> json) => TrendingItems(
        id: json["id"],
        userId: json["user_id"] ?? 0,
        type: typeValues.map[json["type"]]!,
        image: json["image"],
        reelPath: json["reel_path"],
        isLike: json["is_like"] ?? 0,
        isFollow: json["is_follow"] ?? 0,
        product: json["reel_product"] != null
            ? List<ReelProduct>.from(
                json["reel_product"].map((x) => ReelProduct.fromJson(x)))
            : <ReelProduct>[],
        userName: json['user_name'] ?? '',
        userImage: json['profile_img'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": typeValues.reverse[type],
        "image": image,
        "reel_path": reelPath,
        "is_like": isLike,
        "is_follow": isFollow,
        "reel_product": List<dynamic>.from(product.map((x) => x.toJson())),
        "user_name": userName,
        "profile_img": userImage,
        "user_id": userId
      };
}

enum TrendingItemType { PRODUCT, REEL }

final typeValues = EnumValues(
    {"product": TrendingItemType.PRODUCT, "reel": TrendingItemType.REEL});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

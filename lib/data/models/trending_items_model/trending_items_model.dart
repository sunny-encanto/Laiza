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

  TrendingItems({
    required this.id,
    required this.type,
    required this.image,
    required this.reelPath,
    required this.isLike,
  });

  TrendingItems copyWith({int? isLike}) => TrendingItems(
      id: id,
      type: type,
      image: image,
      reelPath: reelPath,
      isLike: isLike ?? this.isLike);

  factory TrendingItems.fromJson(Map<String, dynamic> json) => TrendingItems(
        id: json["id"],
        type: typeValues.map[json["type"]]!,
        image: json["image"],
        reelPath: json["reel_path"],
        isLike: json["is_like"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": typeValues.reverse[type],
        "image": image,
        "reel_path": reelPath,
        "is_like": isLike,
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

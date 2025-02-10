import 'package:laiza/data/models/user/user_model.dart';

import '../product_model/product.dart';
import '../reels_model/reel.dart';

class InfluencerProfileModel {
  String message;
  int status;
  bool error;
  Data data;

  InfluencerProfileModel({
    required this.message,
    required this.status,
    required this.error,
    required this.data,
  });

  factory InfluencerProfileModel.fromJson(Map<String, dynamic> json) =>
      InfluencerProfileModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": data.toJson(),
      };
}

class Data {
  UserModel influencer;
  List<Product> products;
  List<Reel> trendingReels;
  List<Collection> collections;

  Data({
    required this.influencer,
    required this.products,
    required this.trendingReels,
    required this.collections,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        influencer: UserModel.fromJson(
            json: json["influencer"],
            id: (json['influencer']['id']).toString()),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        trendingReels: List<Reel>.from(
            json["trending_reels"].map((x) => Reel.fromJson(x))),
        collections: List<Collection>.from(
            json["collections"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "influencer": influencer.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "trending_reels":
            List<dynamic>.from(trendingReels.map((x) => x.toJson())),
        "collections": List<dynamic>.from(collections.map((x) => x.toJson())),
      };
}

class Collection {
  int id;
  int userId;
  String title;
  List<int> reelIds;
  DateTime createdAt;
  DateTime updatedAt;
  List<Reel> reels;

  Collection({
    required this.id,
    required this.userId,
    required this.title,
    required this.reelIds,
    required this.createdAt,
    required this.updatedAt,
    required this.reels,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        reelIds: List<int>.from(json["reel_ids"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        reels: List<Reel>.from(json["reels"].map((x) => Reel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "reel_ids": List<dynamic>.from(reelIds.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "reels": List<dynamic>.from(reels.map((x) => x.toJson())),
      };
}

import '../user/user_model.dart';

class Reel {
  int id;
  int userId;
  List<String> productId;
  int catId;
  String reelTitle;
  String reelPath;
  int likeStatus;
  String reelDescription;
  String reelCoverPath;
  String reelHashtag;
  int likesCount;
  int commentsCount;
  List<ReelProduct> product;
  UserModel user;

  Reel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.catId,
    required this.reelTitle,
    required this.reelPath,
    required this.likeStatus,
    required this.reelDescription,
    required this.reelCoverPath,
    required this.reelHashtag,
    required this.likesCount,
    required this.commentsCount,
    required this.product,
    required this.user,
  });

  Reel copyWith({int? likeStatus, int? likesCount}) {
    return Reel(
      id: id,
      userId: userId,
      productId: productId,
      catId: catId,
      reelTitle: reelTitle,
      reelPath: reelPath,
      likeStatus: likeStatus ?? this.likeStatus,
      reelDescription: reelDescription,
      reelCoverPath: reelCoverPath,
      reelHashtag: reelHashtag,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount,
      product: product,
      user: user,
    );
  }

  factory Reel.fromJson(Map<String, dynamic> json) => Reel(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"] == null
            ? <String>[]
            : List<String>.from(json["product_id"].map((x) => x)),
        catId: json["category_id"] ?? 0,
        reelTitle: json["reel_title"],
        reelPath: json["reel_path"],
        likeStatus: json['is_like'] ?? 0,
        reelDescription: json["reel_description"],
        reelCoverPath: json["reel_cover_path"],
        reelHashtag: json["reel_hashtag"],
        likesCount: json["likes_count"] ?? 0,
        commentsCount: json["comments_count"] ?? 0,
        product: json["product"] != null
            ? List<ReelProduct>.from(
                json["product"].map((x) => ReelProduct.fromJson(x)))
            : <ReelProduct>[],
        user: json['users'] != null
            ? UserModel.fromJson(
                json: json['users'], id: (json['users']['id']).toString())
            : UserModel(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": List<dynamic>.from(productId.map((x) => x)),
        "reel_title": reelTitle,
        "reel_path": reelPath,
        "is_like": likeStatus,
        "reel_description": reelDescription,
        "reel_cover_path": reelCoverPath,
        "reel_hashtag": reelHashtag,
        "likes_count": likesCount,
        "comments_count": commentsCount,
        "category_id": catId,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        'users': user.toJson()
      };
}

class ReelProduct {
  int id;
  String productName;
  String price;
  String productImage;

  ReelProduct({
    required this.id,
    required this.productName,
    required this.price,
    required this.productImage,
  });

  factory ReelProduct.fromJson(Map<String, dynamic> json) => ReelProduct(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "product_image": productImage,
      };
}

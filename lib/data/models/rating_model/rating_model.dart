import 'package:laiza/data/models/user/user_model.dart';

class Rating {
  int id;
  int userId;
  int productId;
  int rating;
  String review;
  UserModel user;

  Rating({
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    required this.review,
    required this.user,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        rating: json["rating"],
        review: json["review"] ?? '',
        user: UserModel.fromJson(
            json: json["user"], id: (json["user"]["id"]).toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "rating": rating,
        "review": review,
        "user": user.toJson(),
      };
}

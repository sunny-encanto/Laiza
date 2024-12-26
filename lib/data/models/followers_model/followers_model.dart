import 'follower.dart';

class FollowersModel {
  bool success;
  List<Follower> followers;

  FollowersModel({
    required this.success,
    required this.followers,
  });

  factory FollowersModel.fromJson(Map<String, dynamic> json) => FollowersModel(
        success: json["success"],
        followers: List<Follower>.from(
            json["followers"].map((x) => Follower.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "followers": List<dynamic>.from(followers.map((x) => x.toJson())),
      };
}

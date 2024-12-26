import '../followers_model/follower.dart';

class FollowingModel {
  bool success;
  List<Follower> followers;

  FollowingModel({
    required this.success,
    required this.followers,
  });

  factory FollowingModel.fromJson(Map<String, dynamic> json) => FollowingModel(
        success: json["success"],
        followers: List<Follower>.from(
            json["following"].map((x) => Follower.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "followers": List<dynamic>.from(followers.map((x) => x.toJson())),
      };
}

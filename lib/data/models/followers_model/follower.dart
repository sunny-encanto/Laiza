class Follower {
  int id;
  int followerId;
  int followedId;
  int followersCount;
  String profileImg;
  String profileBg;
  String name;

  Follower({
    required this.id,
    required this.followerId,
    required this.followedId,
    required this.followersCount,
    required this.profileImg,
    required this.profileBg,
    required this.name,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        id: json["id"],
        followerId: json["follower_id"],
        followedId: json["followed_id"],
        followersCount: json["followers_count"] ?? 0,
        profileImg: json["profile_img"],
        profileBg: json["profile_background"] ?? '',
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "follower_id": followerId,
        "followed_id": followedId,
        "followers_count": followersCount,
        "profile_img": profileImg,
        "profile_background": profileBg,
        "name": name,
      };
}

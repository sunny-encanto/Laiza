class Follower {
  int id;
  int followerId;
  int followedId;
  String profileImg;
  String name;

  Follower({
    required this.id,
    required this.followerId,
    required this.followedId,
    required this.profileImg,
    required this.name,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        id: json["id"],
        followerId: json["follower_id"],
        followedId: json["followed_id"],
        profileImg: json["profile_img"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "follower_id": followerId,
        "followed_id": followedId,
        "profile_img": profileImg,
        "name": name,
      };
}

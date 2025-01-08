class Reel {
  int id;
  int userId;
  int productId;
  String reelTitle;
  String reelPath;
  int likeStatus;
  String reelDescription;
  String reelCoverPath;
  String reelHashtag;
  int likesCount;
  int commentsCount;

  Reel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.reelTitle,
    required this.reelPath,
    required this.likeStatus,
    required this.reelDescription,
    required this.reelCoverPath,
    required this.reelHashtag,
    required this.likesCount,
    required this.commentsCount,
  });

  Reel copyWith({int? likeStatus, int? likesCount}) {
    return Reel(
      id: id,
      userId: userId,
      productId: productId,
      reelTitle: reelTitle,
      reelPath: reelPath,
      likeStatus: likeStatus ?? this.likeStatus,
      reelDescription: reelDescription,
      reelCoverPath: reelCoverPath,
      reelHashtag: reelHashtag,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount,
    );
  }

  factory Reel.fromJson(Map<String, dynamic> json) => Reel(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        reelTitle: json["reel_title"],
        reelPath: json["reel_path"],
        likeStatus: json['is_like'],
        reelDescription: json["reel_description"],
        reelCoverPath: json["reel_cover_path"],
        reelHashtag: json["reel_hashtag"],
        likesCount: json["likes_count"],
        commentsCount: json["comments_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "reel_title": reelTitle,
        "reel_path": reelPath,
        "is_like": likeStatus,
        "reel_description": reelDescription,
        "reel_cover_path": reelCoverPath,
        "reel_hashtag": reelHashtag,
        "likes_count": likesCount,
        "comments_count": commentsCount,
      };
}

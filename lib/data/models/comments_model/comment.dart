import '../user/user_model.dart';

class Comment {
  int id;
  int parentId;
  int userId;
  int reelId;
  String comment;
  bool isLiked;
  int likeCount;
  List<Comment> replies;
  UserModel user;

  Comment({
    required this.id,
    required this.parentId,
    required this.userId,
    required this.reelId,
    required this.comment,
    required this.isLiked,
    required this.likeCount,
    required this.replies,
    required this.user,
  });

  Comment copyWith({
    bool? isLiked,
    int? likeCount,
    List<Comment>? replies,
  }) {
    return Comment(
      id: id,
      userId: userId,
      parentId: parentId,
      reelId: reelId,
      comment: comment,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      replies: replies ?? this.replies,
      user: user,
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["user_id"],
        parentId: json["parent_id"] ?? 0,
        reelId: json["reel_id"] ?? 0,
        comment: json["comment"],
        isLiked: json['is_like'] ?? false,
        likeCount: json['like_count'] ?? 0,
        replies: json["comments"] == null
            ? <Comment>[]
            : List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x))),
        user: UserModel.fromJson(
            json: json['user'], id: (json['user']['id']).toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "user_id": userId,
        "reel_id": reelId,
        "comment": comment,
        "comments": List<dynamic>.from(replies.map((x) => x.toJson())),
        "like_count": likeCount,
        'is_like': isLiked,
        'user': user.toJson()
      };
}

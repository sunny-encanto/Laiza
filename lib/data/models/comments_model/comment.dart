import '../comment_reply_model/reply.dart';

class Comment {
  int id;
  int userId;
  int reelId;
  String comment;
  bool isLiked;
  int commentCount;
  List<Reply> replies;

  Comment({
    required this.id,
    required this.userId,
    required this.reelId,
    required this.comment,
    required this.isLiked,
    required this.commentCount,
    required this.replies,
  });

  Comment copyWith({
    bool? isLiked,
    int? commentCount,
  }) {
    return Comment(
      id: id,
      userId: userId,
      reelId: reelId,
      comment: comment,
      commentCount: commentCount ?? this.commentCount,
      isLiked: isLiked ?? this.isLiked,
      replies: replies,
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["user_id"],
        reelId: json["reel_id"],
        comment: json["comment"],
        isLiked: json['isLiked'] ?? false,
        commentCount: json['commentCount'] ?? 0,
        replies: json["replies"] == null
            ? <Reply>[]
            : List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "reel_id": reelId,
        "comment": comment,
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
        "commentCount": commentCount,
        'isLiked': isLiked
      };
}

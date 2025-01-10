import '../user/user_model.dart';

class Reply {
  int id;
  int commentId;
  int userId;
  String reply;
  DateTime createdAt;
  DateTime updatedAt;
  UserModel user;

  Reply({
    required this.id,
    required this.commentId,
    required this.userId,
    required this.reply,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["id"],
        commentId: json["comment_id"],
        userId: json["user_id"],
        reply: json["reply"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: UserModel.fromJson(
            json: json["user"], id: (json["user"]['id']).toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment_id": commentId,
        "user_id": userId,
        "reply": reply,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

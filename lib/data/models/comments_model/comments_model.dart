import 'comment.dart';

class CommentModel {
  String message;
  int status;
  bool error;
  int commentCount;
  List<Comment> comment;

  CommentModel({
    required this.message,
    required this.status,
    required this.error,
    required this.commentCount,
    required this.comment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        commentCount: json["comment_count"],
        comment:
            List<Comment>.from(json["comment"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "comment_count": commentCount,
        "comment": List<dynamic>.from(comment.map((x) => x.toJson())),
      };
}

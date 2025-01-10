import 'package:laiza/data/models/comments_model/comment.dart';

class CommentReplyModel {
  String message;
  int status;
  bool error;
  List<Comment> data;

  CommentReplyModel({
    required this.message,
    required this.status,
    required this.error,
    required this.data,
  });

  factory CommentReplyModel.fromJson(Map<String, dynamic> json) =>
      CommentReplyModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        data: List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CommonModel {
  int? status;
  int? userId;
  String? userEmail;
  String? message;

  CommonModel({this.status, this.userId, this.userEmail, this.message});

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
        status: json['status'] as int?,
        userId: json['user_id'] as int?,
        userEmail: json['user_email'] as String?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'user_id': userId,
        'user_email': userEmail,
        'message': message,
      };
}

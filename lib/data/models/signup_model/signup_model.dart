class SignupModel {
  int? status;
  int? userId;
  String? message;

  SignupModel({this.status, this.userId, this.message});

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        status: json['status'] as int?,
        userId: json['user_id'] as int?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'user_id': userId,
        'message': message,
      };
}

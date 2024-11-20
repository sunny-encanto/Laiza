class OtpVerificationModel {
  int? status;
  String? message;
  int? userId;
  String? token;

  OtpVerificationModel({
    this.status,
    this.message,
    this.userId,
    this.token,
  });

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) {
    return OtpVerificationModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      userId: json['user_id'] as int?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'user_id': userId,
        'token': token,
      };
}

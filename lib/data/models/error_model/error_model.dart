class ErrorModel {
  int? status;
  String? message;

  ErrorModel({this.status, this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        status: json['status'] as int?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}

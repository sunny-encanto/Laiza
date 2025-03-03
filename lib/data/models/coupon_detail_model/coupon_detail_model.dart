class CouponDetailsModel {
  bool success;
  CouponDetail data;
  String message;

  CouponDetailsModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory CouponDetailsModel.fromJson(Map<String, dynamic> json) =>
      CouponDetailsModel(
        success: json["success"],
        data: CouponDetail.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class CouponDetail {
  int id;
  String title;
  int amount;
  String type;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;

  CouponDetail({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CouponDetail.fromJson(Map<String, dynamic> json) => CouponDetail(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
        type: json["type"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
        "type": type,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

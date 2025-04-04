class MyScheduledStreamModel {
  bool success;
  List<MyScheduledStream> data;
  String message;

  MyScheduledStreamModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory MyScheduledStreamModel.fromJson(Map<String, dynamic> json) =>
      MyScheduledStreamModel(
        success: json["success"],
        data: List<MyScheduledStream>.from(
            json["data"].map((x) => MyScheduledStream.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class MyScheduledStream {
  int id;
  int userId;
  String title;
  String description;
  DateTime date;
  String time;
  List<String> productId;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  Users users;

  MyScheduledStream({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.users,
  });

  factory MyScheduledStream.fromJson(Map<String, dynamic> json) =>
      MyScheduledStream(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        productId: List<String>.from(json["product_id"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        users: Users.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "product_id": List<dynamic>.from(productId.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "users": users.toJson(),
      };
}

class Users {
  int id;
  String name;
  String userType;
  String profileImg;

  Users({
    required this.id,
    required this.name,
    required this.userType,
    required this.profileImg,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        userType: json["user_type"],
        profileImg: json["profile_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_type": userType,
        "profile_img": profileImg,
      };
}

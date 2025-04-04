import 'package:laiza/data/models/user/user_model.dart';

class UpComingStreamModel {
  List<UpComingStream> upComingStream;
  String message;
  int status;
  bool error;

  UpComingStreamModel({
    required this.upComingStream,
    required this.message,
    required this.status,
    required this.error,
  });

  factory UpComingStreamModel.fromJson(Map<String, dynamic> json) =>
      UpComingStreamModel(
        upComingStream: List<UpComingStream>.from(
            json["data"].map((x) => UpComingStream.fromJson(x))),
        message: json["message"],
        status: json["status"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(upComingStream.map((x) => x.toJson())),
        "message": message,
        "status": status,
        "error": error,
      };
}

class UpComingStream {
  int id;
  int userId;
  String title;
  String description;
  String date;
  String time;
  List<String> productId;
  UserModel users;
  bool isNotify;

  UpComingStream({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.productId,
    required this.users,
    required this.isNotify,
  });

  // copyWith method
  UpComingStream copyWith({
    bool? isNotify,
  }) {
    return UpComingStream(
      id: id,
      userId: userId,
      title: title,
      description: description,
      date: date,
      time: time,
      productId: productId,
      users: users,
      isNotify: isNotify ?? this.isNotify,
    );
  }

  factory UpComingStream.fromJson(Map<String, dynamic> json) => UpComingStream(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        time: json["time"],
        isNotify: json["is_notify"],
        productId: json["product_id"] == null
            ? <String>[]
            : List<String>.from(json["product_id"].map((x) => x)),
        users: UserModel.fromJson(
            json: json["users"], id: (json['users']['id']).toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "date": date,
        "time": time,
        "is_notify": isNotify,
        "product_id": List<dynamic>.from(productId.map((x) => x)),
        "users": users.toJson(),
      };
}

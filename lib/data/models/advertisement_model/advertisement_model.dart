class AdvertisementModel {
  List<Advertisement> advertisements;
  String message;
  int status;
  bool error;

  AdvertisementModel({
    required this.advertisements,
    required this.message,
    required this.status,
    required this.error,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementModel(
        advertisements: List<Advertisement>.from(
            json["data"].map((x) => Advertisement.fromJson(x))),
        message: json["message"],
        status: json["status"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(advertisements.map((x) => x.toJson())),
        "message": message,
        "status": status,
        "error": error,
      };
}

class Advertisement {
  int id;
  String title;
  String image;

  Advertisement({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) => Advertisement(
        id: json["id"],
        title: json["title"] ?? '',
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
      };
}

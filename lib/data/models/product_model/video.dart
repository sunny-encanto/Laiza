class Video {
  int id;
  int productId;
  String videoPath;

  Video({
    required this.id,
    required this.productId,
    required this.videoPath,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        productId: json["product_id"],
        videoPath: json["video_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "video_path": videoPath,
      };
}

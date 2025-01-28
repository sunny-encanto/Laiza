class Image {
  int id;
  int productId;
  String imagePath;

  Image({
    required this.id,
    required this.productId,
    required this.imagePath,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["product_id"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "image_path": imagePath,
      };
}

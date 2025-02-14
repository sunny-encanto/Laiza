import 'package:laiza/data/models/product_model/product.dart';

class AllProductModel {
  List<Product> data;
  String message;

  AllProductModel({
    required this.data,
    required this.message,
  });

  factory AllProductModel.fromJson(Map<String, dynamic> json) =>
      AllProductModel(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

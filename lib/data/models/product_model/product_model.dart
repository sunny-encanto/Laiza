import 'package:laiza/data/models/product_model/product.dart';

class ProductModel {
  String message;
  int status;
  bool error;
  Product data;

  ProductModel({
    required this.message,
    required this.status,
    required this.error,
    required this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        data: Product.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": data.toJson(),
      };
}

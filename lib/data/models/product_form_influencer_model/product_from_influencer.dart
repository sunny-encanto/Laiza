import '../product_model/product.dart';

class ProductFromInfluencerModel {
  String message;
  int status;
  bool error;
  List<Product> data;

  ProductFromInfluencerModel({
    required this.message,
    required this.status,
    required this.error,
    required this.data,
  });

  factory ProductFromInfluencerModel.fromJson(Map<String, dynamic> json) =>
      ProductFromInfluencerModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

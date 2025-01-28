import 'package:laiza/data/models/product_model/product.dart';

class AllProductModel {
  bool success;
  AllProductData data;
  String message;

  AllProductModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory AllProductModel.fromJson(Map<String, dynamic> json) =>
      AllProductModel(
        success: json["success"],
        data: AllProductData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class AllProductData {
  int currentPage;
  List<Product> data;
  String firstPageUrl;
  int total;
  String nextPageUrl;

  AllProductData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.total,
    required this.nextPageUrl,
  });

  factory AllProductData.fromJson(Map<String, dynamic> json) => AllProductData(
      currentPage: json["current_page"],
      data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      firstPageUrl: json["first_page_url"],
      total: json["total"],
      nextPageUrl: json["next_page_url"] ?? '');

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "total": total,
        "next_page_url": nextPageUrl
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] ?? '',
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

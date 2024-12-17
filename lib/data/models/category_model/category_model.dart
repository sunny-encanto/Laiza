import 'Category.dart';

class CategoryModel {
  bool? success;
  String? message;
  List<Category>? category;

  CategoryModel({
    this.success,
    this.message,
    this.category,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        category: json["category"] == null
            ? <Category>[]
            : List<Category>.from(
                json["category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (category != null) {
      map['category'] = category?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

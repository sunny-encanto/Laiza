class Category {
  num? id;
  String? categoryName;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.categoryName,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(dynamic json) => Category(
        id: json['id'],
        categoryName: json['category_name'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_name'] = categoryName;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

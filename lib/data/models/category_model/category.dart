class Category {
  num? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(dynamic json) => Category(
        id: json['id'],
        name: json['title'],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = name;

    return map;
  }
}

class ProductCategory {
  num? id;
  String? name;

  ProductCategory({
    this.id,
    this.name,
  });

  factory ProductCategory.fromJson(dynamic json) => ProductCategory(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;

    return map;
  }
}

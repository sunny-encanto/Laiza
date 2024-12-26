class Category {
  num? id;
  String? categoryName;

  Category({
    this.id,
    this.categoryName,
  });

  factory Category.fromJson(dynamic json) => Category(
        id: json['id'],
        categoryName: json['title'],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = categoryName;

    return map;
  }
}

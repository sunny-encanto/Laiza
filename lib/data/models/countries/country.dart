class Country {
  int id;
  String code;
  String name;
  int phonecode;

  Country({
    required this.id,
    required this.code,
    required this.name,
    required this.phonecode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        phonecode: json["phonecode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "phonecode": phonecode,
      };
}

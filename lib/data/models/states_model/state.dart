class State {
  int id;
  String name;
  int countryId;

  State({
    required this.id,
    required this.name,
    required this.countryId,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
      };
}

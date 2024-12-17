import 'country.dart';

class CountriesModel {
  bool success;
  List<Country> countries;
  String message;

  CountriesModel({
    required this.success,
    required this.countries,
    required this.message,
  });

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
        success: json["success"],
        countries:
            List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(countries.map((x) => x.toJson())),
        "message": message,
      };
}

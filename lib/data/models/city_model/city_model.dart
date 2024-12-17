import 'package:laiza/data/models/city_model/city.dart';

class CityModel {
  bool success;
  List<City> cities;
  String message;

  CityModel({
    required this.success,
    required this.cities,
    required this.message,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        success: json["success"],
        cities: List<City>.from(json["data"].map((x) => City.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(cities.map((x) => x.toJson())),
        "message": message,
      };
}

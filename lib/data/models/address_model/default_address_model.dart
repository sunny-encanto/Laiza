import 'package:laiza/data/models/address_model/address_model.dart';

class DefaultAddressModel {
  String message;
  int status;
  bool error;
  Address address;

  DefaultAddressModel({
    required this.message,
    required this.status,
    required this.error,
    required this.address,
  });

  factory DefaultAddressModel.fromJson(Map<String, dynamic> json) =>
      DefaultAddressModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        address:
            json["data"] == null ? Address() : Address.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": address.toJson(),
      };
}

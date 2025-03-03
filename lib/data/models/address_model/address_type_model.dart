class AddressTypeModel {
  String message;
  int status;
  bool error;
  List<AddressType> addressType;

  AddressTypeModel({
    required this.message,
    required this.status,
    required this.error,
    required this.addressType,
  });

  factory AddressTypeModel.fromJson(Map<String, dynamic> json) =>
      AddressTypeModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        addressType: List<AddressType>.from(
            json["data"].map((x) => AddressType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": List<dynamic>.from(addressType.map((x) => x.toJson())),
      };
}

class AddressType {
  int id;
  String name;

  AddressType({
    required this.id,
    required this.name,
  });

  factory AddressType.fromJson(Map<String, dynamic> json) => AddressType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class AddressModel {
  String? message;
  int? status;
  bool? error;
  List<Address>? addressList;

  AddressModel({
    this.message,
    this.status,
    this.error,
    this.addressList,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        addressList: json["data"] == null
            ? []
            : List<Address>.from(json["data"]!.map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": addressList == null
            ? []
            : List<dynamic>.from(addressList!.map((x) => x.toJson())),
      };
}

class Address {
  int? userId;
  String? addressType;
  String? houseNo;
  String? areaStreet;
  String? landmark;
  String? pinCode;
  String? city;
  String? country;
  String? state;
  int? makeDefaultAddress;
  int? id;

  Address({
    this.userId,
    this.addressType,
    this.houseNo,
    this.areaStreet,
    this.landmark,
    this.pinCode,
    this.city,
    this.state,
    this.country,
    this.makeDefaultAddress,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        userId: json["user_id"],
        addressType: json["address_type"],
        houseNo: json["house_no"],
        areaStreet: json["area_street"],
        landmark: json["landmark"],
        pinCode: json["pincode"],
        city: json["city"],
        state: json["state"],
        country: json["country"] ?? 0,
        makeDefaultAddress: json["make_default_address"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (userId != null) map["user_id"] = userId;
    if (addressType != null) map["address_type"] = addressType;
    if (houseNo != null) map["house_no"] = houseNo;
    if (areaStreet != null) map["area_street"] = areaStreet;
    if (landmark != null) map["landmark"] = landmark;
    if (pinCode != null) map["pincode"] = pinCode;
    if (city != null) map["city"] = city;
    if (state != null) map["state"] = state;
    if (country != null) map["country"] = country;
    if (makeDefaultAddress != null) {
      map["make_default_address"] = makeDefaultAddress;
    }
    if (id != null) map["id"] = id;
    return map;
  }
}

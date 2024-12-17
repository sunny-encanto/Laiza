import 'user_profile_data.dart';

class UserProfileModel {
  bool? success;
  UserProfileDataData? data;
  String? message;

  UserProfileModel({
    this.success,
    this.data,
    this.message,
  });

  UserProfileModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null
        ? UserProfileDataData.fromJson(json['data'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    return map;
  }
}

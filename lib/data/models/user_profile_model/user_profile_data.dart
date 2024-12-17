import 'package:laiza/data/models/user/user_model.dart';

class UserProfileDataData {
  UserProfileDataData({
    this.user,
  });

  UserProfileDataData.fromJson(dynamic json) {
    user = json['user'] != null
        ? UserModel.fromJson(
            json: json['user'], id: json['user']['id'].toString())
        : null;
  }

  UserModel? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

import '../user/user_model.dart';

class AllInfluencerModel {
  bool? success;
  List<UserModel> influencers;
  String? message;

  AllInfluencerModel({this.success, required this.influencers, this.message});

  factory AllInfluencerModel.fromJson(Map<String, dynamic> json) {
    return AllInfluencerModel(
      success: json['success'] as bool?,
      influencers: json['data'] == null
          ? <UserModel>[]
          : List<UserModel>.from(json["data"]
              .map((x) => UserModel.fromJson(json: x, id: x['id'].toString()))),
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        "data":
            List<dynamic>.from(influencers.map((UserModel x) => x.toJson())),
        'message': message,
      };
}

import 'package:laiza/data/models/influencer_profile_model/influencer_profile_model.dart';

class CollectionModel {
  String message;
  int status;
  bool error;
  List<Collection> collection;

  CollectionModel({
    required this.message,
    required this.status,
    required this.error,
    required this.collection,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      CollectionModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        collection: List<Collection>.from(
            json["data"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": List<dynamic>.from(collection.map((x) => x.toJson())),
      };
}

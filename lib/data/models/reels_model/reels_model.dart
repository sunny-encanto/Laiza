import 'reel.dart';

class ReelModel {
  String message;
  int status;
  bool error;
  List<Reel> reels;

  ReelModel({
    required this.message,
    required this.status,
    required this.error,
    required this.reels,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) => ReelModel(
        message: json["message"],
        status: json["status"],
        error: json["error"],
        reels: List<Reel>.from(json["data"].map((x) => Reel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "error": error,
        "data": List<dynamic>.from(reels.map((x) => x.toJson())),
      };
}

List<String> reelUrl = <String>[
  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
  'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
  'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
];

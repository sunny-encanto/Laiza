class ReelsModel {
  final String id;
  bool likeStatus;
  final String url;

  ReelsModel({required this.id, required this.likeStatus, required this.url});
}

List<String> reelUrl = <String>[
  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
  'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
  'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
];
List<ReelsModel> realList = <ReelsModel>[
  ReelsModel(
      id: '1',
      likeStatus: false,
      url:
          'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'),
  ReelsModel(
      id: '1',
      likeStatus: false,
      url:
          'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'),
  ReelsModel(
      id: '1',
      likeStatus: false,
      url:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4'),
  ReelsModel(
      id: '1',
      likeStatus: false,
      url:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4'),
  ReelsModel(
      id: '1',
      likeStatus: false,
      url:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'),
];

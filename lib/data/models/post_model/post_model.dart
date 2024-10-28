class Post {
  final int id;
  final String url;
  final bool isVideo;
  final String? videoUrl;
  final bool isSelected;

  Post({
    required this.id,
    required this.url,
    required this.isVideo,
    this.videoUrl,
    this.isSelected = false,
  });

  Post copyWith({bool? isSelected}) {
    return Post(
      id: id,
      url: url,
      isVideo: isVideo,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

List<Post> postList = <Post>[
  Post(
    id: 1,
    url: 'https://i.imgur.com/CzXTtJV.jpg',
    isVideo: false,
  ),
  Post(
    id: 2,
    url: 'https://i.imgur.com/OB0y6MR.jpg',
    isVideo: true,
    videoUrl:
        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
  ),
  Post(
    id: 3,
    url: 'https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg',
    isVideo: false,
  ),
  Post(
    id: 4,
    url: 'https://farm4.staticflickr.com/3075/3168662394_7d7103de7d_z_d.jpg',
    isVideo: false,
  ),
  Post(
      id: 5,
      url: 'https://farm9.staticflickr.com/8505/8441256181_4e98d8bff5_z_d.jpg',
      isVideo: true,
      videoUrl:
          'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'),
  Post(
    id: 6,
    url: 'https://farm3.staticflickr.com/2220/1572613671_7311098b76_z_d.jpg',
    isVideo: false,
  ),
  Post(
    id: 7,
    url: 'https://farm2.staticflickr.com/1090/4595137268_0e3f2b9aa7_z_d.jpg',
    isVideo: false,
  ),
  Post(
    id: 8,
    url: 'https://farm4.staticflickr.com/3224/3081748027_0ee3d59fea_z_d.jpg',
    isVideo: true,
    videoUrl:
        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
  ),
  Post(
    id: 9,
    url: 'https://farm8.staticflickr.com/7377/9359257263_81b080a039_z_d.jpg',
    isVideo: false,
  ),
  Post(
    id: 10,
    url: 'https://farm9.staticflickr.com/8295/8007075227_dc958c1fe6_z_d.jpg',
    isVideo: false,
  ),
  Post(
    id: 11,
    url: 'https://farm2.staticflickr.com/1449/24800673529_64272a66ec_z_d.jpg',
    isVideo: false,
  ),
  Post(
    id: 12,
    url: 'https://farm4.staticflickr.com/3752/9684880330_9b4698f7cb_z_d.jpg',
    isVideo: false,
  ),
];

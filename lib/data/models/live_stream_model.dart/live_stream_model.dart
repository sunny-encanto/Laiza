class LiveStreamModel {
  final String? liveId;
  final String? userId;
  final String? userName;
  final String? title;
  final String? userProfile;
  final int? viewCount;
  final bool? isNotify;

  LiveStreamModel({
    this.liveId,
    this.userId,
    this.userName,
    this.title,
    this.userProfile,
    this.viewCount,
    this.isNotify,
  });

  // fromMap method to parse Map into an instance of LiveStreamModel
  factory LiveStreamModel.fromMap(Map<String, dynamic> map) {
    return LiveStreamModel(
      liveId: map['liveId'] as String?,
      userId: map['userId'] as String?,
      userName: map['userName'] as String?,
      userProfile: map['userProfile'] as String?,
      viewCount: map['viewCount'] as int?,
      isNotify: map['is_notify'] as bool?,
    );
  }

  // toMap method to convert an instance of LiveStreamModel into Map format
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};

    if (liveId != null) data['liveId'] = liveId;
    if (userId != null) data['userId'] = userId;
    if (userName != null) data['userName'] = userName;
    if (userProfile != null) data['userProfile'] = userProfile;
    if (viewCount != null) data['viewCount'] = viewCount;
    if (isNotify != null) data['is_notify'] = isNotify;
    return data;
  }
}

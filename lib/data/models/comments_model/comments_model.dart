import 'package:laiza/core/app_export.dart';

class CommentModel {
  final int id;
  final String name;
  final String comment;
  final String profile;
  int commentCount;
  bool isLiked;
  CommentModel({
    required this.id,
    required this.name,
    required this.comment,
    required this.profile,
    required this.commentCount,
    required this.isLiked,
  });

  CommentModel copyWith({
    bool? isLiked,
    int? commentCount,
  }) {
    return CommentModel(
      id: id,
      isLiked: isLiked ?? this.isLiked,
      name: name,
      comment: comment,
      profile: profile,
      commentCount: commentCount ?? this.commentCount,
    );
  }
}

List<CommentModel> commentList = <CommentModel>[
  CommentModel(
    id: 1,
    name: 'Isha Thapar',
    comment: 'Wow, Classic & Elegant I am definitely going to buy',
    profile: ImageConstant.profileBg,
    commentCount: 12,
    isLiked: false,
  ),
  CommentModel(
    id: 2,
    name: 'Isha Thapar',
    comment: 'Wow, Classic & Elegant I am definitely going to buy',
    profile: ImageConstant.profileBg,
    commentCount: 12,
    isLiked: false,
  )
];

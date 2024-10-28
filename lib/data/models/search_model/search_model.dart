import 'package:laiza/core/app_export.dart';

class SearchModel {
  final int id;
  final String name;
  final String followersCount;
  final String profile;

  SearchModel(
      {required this.id,
      required this.name,
      required this.followersCount,
      required this.profile});
}

List<SearchModel> searchResult = <SearchModel>[
  SearchModel(
    id: 1,
    name: 'Kristen Stewart ',
    followersCount: '100K Followers',
    profile: ImageConstant.profileBg,
  ),
  SearchModel(
    id: 1,
    name: 'Stewart ',
    followersCount: '100K Followers',
    profile: ImageConstant.profileBg,
  ),
  SearchModel(
    id: 1,
    name: 'Riya Stewart ',
    followersCount: '100K Followers',
    profile: ImageConstant.profileBg,
  ),
];

import 'package:laiza/core/app_export.dart';

class ConnectionsModel {
  final int id;
  final String name;
  final String category;
  final String profile;

  ConnectionsModel(
      {required this.id,
      required this.name,
      required this.category,
      required this.profile});
}

List<ConnectionsModel> connectionsList = <ConnectionsModel>[
  ConnectionsModel(
      id: 1,
      name: 'Krithika Thapar',
      category: 'Cosmetics',
      profile: ImageConstant.profileBg),
  ConnectionsModel(
      id: 2,
      name: 'Devendra Soni',
      category: 'Cosmetics',
      profile: ImageConstant.profileBg),
  ConnectionsModel(
      id: 3,
      name: 'Rishabh Sharma',
      category: 'Cosmetics',
      profile: ImageConstant.profileBg),
  ConnectionsModel(
      id: 4,
      name: 'Kunal Kapoor',
      category: 'Cosmetics',
      profile: ImageConstant.profileBg),
];

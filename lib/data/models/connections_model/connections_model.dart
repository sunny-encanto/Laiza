import 'package:laiza/core/app_export.dart';

class ConnectionsModel {
  final int id;
  final String name;
  final String category;
  final String profile;
  final bool isConnected;

  ConnectionsModel({
    required this.id,
    required this.name,
    required this.category,
    required this.profile,
    required this.isConnected,
  });

  ConnectionsModel copyWith({bool? isConnected}) => ConnectionsModel(
        id: id,
        name: name,
        category: category,
        profile: profile,
        isConnected: isConnected ?? this.isConnected,
      );
}

List<ConnectionsModel> connectionsList = <ConnectionsModel>[
  ConnectionsModel(
    id: 1,
    name: 'Krithika Thapar',
    category: 'Cosmetics',
    profile: ImageConstant.profileBg,
    isConnected: false,
  ),
  ConnectionsModel(
    id: 2,
    name: 'Devendra Soni',
    category: 'Cosmetics',
    profile: ImageConstant.profileBg,
    isConnected: false,
  ),
  ConnectionsModel(
    id: 3,
    name: 'Rishabh Sharma',
    category: 'Cosmetics',
    profile: ImageConstant.profileBg,
    isConnected: false,
  ),
  ConnectionsModel(
    id: 4,
    name: 'Kunal Kapoor',
    category: 'Cosmetics',
    profile: ImageConstant.profileBg,
    isConnected: false,
  ),
];

class ConnectionRequestModel {
  final int id;
  final String name;
  final String profile;
  final String category;
  final String description;
  String requestStatus;

  ConnectionRequestModel({
    required this.id,
    required this.name,
    required this.profile,
    required this.category,
    required this.description,
    required this.requestStatus,
  });

  ConnectionRequestModel copyWith({String? requestStatus}) {
    return ConnectionRequestModel(
        id: id,
        name: name,
        profile: profile,
        category: category,
        description: description,
        requestStatus: requestStatus ?? this.requestStatus);
  }
}

enum ConnectionRequestStatus {
  pending,
  rejected,
  accepted,
}

List<ConnectionRequestModel> connectionRequestList = <ConnectionRequestModel>[
  ConnectionRequestModel(
    id: 1,
    name: 'Kratika Thapar',
    profile:
        'https://as2.ftcdn.net/v2/jpg/03/83/25/83/1000_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
    category: 'Comsmetics',
    description:
        "Seller’s Message-Hi Carol, I represent a cosmetics brand specializing in high-quality, natural beauty products. I believe your content aligns perfectly with our brand, and I'd love to collaborate with you to promote our latest skincare line. Looking forward to your response!",
    requestStatus: ConnectionRequestStatus.pending.name,
  ),
  ConnectionRequestModel(
    id: 2,
    name: 'Kratika Thapar',
    profile:
        'https://as2.ftcdn.net/v2/jpg/03/83/25/83/1000_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
    category: 'Comsmetics',
    description:
        "Seller’s Message-Hi Carol, I represent a cosmetics brand specializing in high-quality, natural beauty products. I believe your content aligns perfectly with our brand, and I'd love to collaborate with you to promote our latest skincare line. Looking forward to your response!",
    requestStatus: ConnectionRequestStatus.pending.name,
  ),
  ConnectionRequestModel(
    id: 3,
    name: 'Kratika Thapar',
    profile:
        'https://as2.ftcdn.net/v2/jpg/03/83/25/83/1000_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
    category: 'Comsmetics',
    description:
        "Seller’s Message-Hi Carol, I represent a cosmetics brand specializing in high-quality, natural beauty products. I believe your content aligns perfectly with our brand, and I'd love to collaborate with you to promote our latest skincare line. Looking forward to your response!",
    requestStatus: ConnectionRequestStatus.pending.name,
  ),
];

class MyConnectionsModel {
  bool success;
  int connectionCount;
  List<Connection> connections;

  MyConnectionsModel({
    required this.success,
    required this.connectionCount,
    required this.connections,
  });

  factory MyConnectionsModel.fromJson(Map<String, dynamic> json) =>
      MyConnectionsModel(
        success: json["success"],
        connectionCount: json["connection_count"],
        connections: List<Connection>.from(
            json["connections"].map((x) => Connection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "connection_count": connectionCount,
        "connections": List<dynamic>.from(connections.map((x) => x.toJson())),
      };
}

class Connection {
  int id;

  String profileImg;
  String name;
  String brandName;

  Connection({
    required this.id,
    required this.profileImg,
    required this.name,
    required this.brandName,
  });

  factory Connection.fromJson(Map<String, dynamic> json) => Connection(
        id: json["id"],
        profileImg: json["profile_img"],
        name: json["name"],
        brandName: json["brand_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_img": profileImg,
        "name": name,
        "brand_name": brandName,
      };
}

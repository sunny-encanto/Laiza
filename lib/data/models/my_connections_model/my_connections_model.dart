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
  int senderId;
  String senderType;
  int receiverId;
  String receiverType;
  String status;
  String profileImg;
  String name;

  Connection({
    required this.id,
    required this.senderId,
    required this.senderType,
    required this.receiverId,
    required this.receiverType,
    required this.status,
    required this.profileImg,
    required this.name,
  });

  factory Connection.fromJson(Map<String, dynamic> json) => Connection(
        id: json["id"],
        senderId: json["sender_id"],
        senderType: json["sender_type"],
        receiverId: json["receiver_id"],
        receiverType: json["receiver_type"],
        status: json["status"],
        profileImg: json["profile_img"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "sender_type": senderType,
        "receiver_id": receiverId,
        "receiver_type": receiverType,
        "status": status,
        "profile_img": profileImg,
        "name": name,
      };
}

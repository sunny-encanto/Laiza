class ConnectionRequestModel {
  String message;
  List<ConnectionRequest> requests;

  ConnectionRequestModel({
    required this.message,
    required this.requests,
  });

  factory ConnectionRequestModel.fromJson(Map<String, dynamic> json) =>
      ConnectionRequestModel(
        message: json["message"],
        requests: List<ConnectionRequest>.from(
            json["data"].map((x) => ConnectionRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(requests.map((x) => x.toJson())),
      };
}

class ConnectionRequest {
  int id;
  int senderId;
  String senderType;
  int receiverId;
  String receiverType;
  ConnectionRequestStatus status;
  Receiver sender;
  Receiver receiver;

  ConnectionRequest({
    required this.id,
    required this.senderId,
    required this.senderType,
    required this.receiverId,
    required this.receiverType,
    required this.status,
    required this.sender,
    required this.receiver,
  });

  ConnectionRequest copyWith({
    ConnectionRequestStatus? status,
  }) =>
      ConnectionRequest(
          id: id,
          senderId: senderId,
          senderType: senderType,
          receiverId: receiverId,
          receiverType: receiverType,
          status: status ?? this.status,
          sender: sender,
          receiver: receiver);

  factory ConnectionRequest.fromJson(Map<String, dynamic> json) =>
      ConnectionRequest(
        id: json["id"],
        senderId: json["sender_id"],
        senderType: json["sender_type"],
        receiverId: json["receiver_id"],
        receiverType: json["receiver_type"],
        status: ConnectionRequestStatus.values
            .firstWhere((e) => e.toString().split('.').last == json["status"]),
        sender: Receiver.fromJson(json["sender"]),
        receiver: Receiver.fromJson(json["receiver"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "sender_type": senderType,
        "receiver_id": receiverId,
        "receiver_type": receiverType,
        "status": status.toString().split('.').last,
        "sender": sender.toJson(),
        "receiver": receiver.toJson(),
      };
}

class Receiver {
  int id;
  String name;

  Receiver({
    required this.id,
    required this.name,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

enum ConnectionRequestStatus {
  pending,
  accepted,
  rejected,
  canceled,
}

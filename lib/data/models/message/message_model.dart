class Message {
  final String? dcoId;
  final String? roomId;
  final String? receiverId;
  final String? senderId;
  final String? message;
  final String? timestamp;
  final String? type;
  final String? url;
  final String? fileName;
  final String? fileExtension;
  final bool? isSeen;
  final int? linkCount;
  final List? userIdsOfUsersForDeletedMessage;
  final String? thumbnailUrl;

  final int? voiceDuration;

  Message({
    this.dcoId,
    this.roomId,
    this.receiverId,
    this.senderId,
    this.message,
    this.timestamp,
    this.type,
    this.url,
    this.linkCount,
    this.fileName,
    this.fileExtension,
    this.isSeen,
    this.userIdsOfUsersForDeletedMessage,
    this.thumbnailUrl,
    this.voiceDuration,
  });

  factory Message.fromJson(
      {required Map<String, dynamic> json, required String id}) {
    return Message(
        dcoId: id,
        roomId: json["roomId"] ?? '',
        receiverId: json['receiverId'] ?? '',
        senderId: json['senderId'] ?? '',
        message: json['message'] ?? '',
        timestamp: json['timestamp'] ?? '',
        type: json['type'] ?? '',
        linkCount: json['linkCount'] ?? 0,
        url: json['url'] ?? '',
        isSeen: json['isSeen'] ?? false,
        userIdsOfUsersForDeletedMessage:
            json['userIdsOfUsersForDeletedMessage'] ?? [],
        fileName: json['fileName'] ?? '',
        fileExtension: json['fileExtension'] ?? '',
        thumbnailUrl: json['thumbnailUrl'] ?? '',
        voiceDuration: json['voiceDuration'] ?? 60);
  }

  Map<String, dynamic> toJson() {
    return {
      if (roomId != null) 'roomId': roomId,
      if (dcoId != null) 'roomId': dcoId,
      if (receiverId != null) 'receiverId': receiverId,
      if (senderId != null) 'senderId': senderId,
      if (message != null) 'message': message,
      if (timestamp != null) 'timestamp': timestamp,
      if (type != null) 'type': type,
      if (url != null) 'url': url,
      if (fileName != null) 'fileName': fileName,
      if (fileExtension != null) 'fileExtension': fileExtension,
      if (linkCount != null) 'linkCount': linkCount,
      if (isSeen != null) 'isSeen': isSeen,
      if (userIdsOfUsersForDeletedMessage != null)
        'userIdsOfUsersForDeletedMessage': userIdsOfUsersForDeletedMessage,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      if (voiceDuration != null) 'voiceDuration': voiceDuration,
    };
  }
}

// ignore: constant_identifier_names
enum MessageType { Text, Voice, Media, Video, Travel }

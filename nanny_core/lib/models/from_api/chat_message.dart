class ChatMessage {
  ChatMessage({
    this.id,
    required this.idChat,
    required this.msg,
    required this.msgType,
    required this.timestampSend,
    this.isMe = false,
    this.edited = false,
  });

  final int? id;
  final int idChat;
  final String msg;
  int msgType;
  final double timestampSend;
  final bool isMe;
  final bool edited;

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json["id"],
      idChat: json["id_chat"] ?? 0,
      msg: json["msg"] ?? "",
      msgType: json["msgType"] ?? 0,
      timestampSend: (json["timestamp_send"] as num?)?.toDouble() ?? 0,
      isMe: json["isMe"] ?? false,
      edited: json["edited"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_chat": idChat,
        "msg": msg,
        "msgType": msgType,
        "isMe": isMe,
        "edited": edited,
      };

  ChatMessage copyWith({
    int? id,
    int? idChat,
    String? msg,
    int? msgType,
    double? timestampSend,
    bool? isMe,
    bool? edited,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      idChat: idChat ?? this.idChat,
      msg: msg ?? this.msg,
      msgType: msgType ?? this.msgType,
      timestampSend: timestampSend ?? this.timestampSend,
      isMe: isMe ?? this.isMe,
      edited: edited ?? this.edited,
    );
  }
}

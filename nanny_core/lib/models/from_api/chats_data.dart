class ChatsData {
    ChatsData({
        required this.chats,
        required this.total,
    });

    final List<ChatElement> chats;
    final int total;

    factory ChatsData.fromJson(Map<String, dynamic> json){ 
        return ChatsData(
            chats: json["chats"] == null ? [] : List<ChatElement>.from(json["chats"]!.map((x) => ChatElement.fromJson(x))),
            total: json["total"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "chats": chats.map((x) => x.toJson()).toList(),
        "total": total,
    };

}

class ChatElement {
    ChatElement({
        required this.idChat,
        required this.username,
        required this.photoPath,
        required this.message,
    });

    final int idChat;
    final String username;
    final String photoPath;
    final MessageElement? message;

    factory ChatElement.fromJson(Map<String, dynamic> json){ 
        return ChatElement(
            idChat: json["id_chat"] ?? 0,
            username: json["username"] ?? "",
            photoPath: json["photo_path"] ?? "",
            message: json["message"] == null ? null : MessageElement.fromJson(json["message"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id_chat": idChat,
        "username": username,
        "photo_path": photoPath,
        "message": message?.toJson(),
    };

}

class MessageElement {
    MessageElement({
      required this.msg,
      required this.time,
      this.newMessages = 0
    });

    final String msg;
    final int newMessages;
    final int time;

    factory MessageElement.fromJson(Map<String, dynamic> json){ 
      return MessageElement(
        msg: json["msg"] ?? "",
        time: json["time"] ?? 0,
        newMessages: json["new_message"] ?? 0
      );
    }

    Map<String, dynamic> toJson() => {
      "msg": msg,
      "time": time,
    };

}

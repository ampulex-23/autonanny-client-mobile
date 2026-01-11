import 'package:nanny_core/models/from_api/chat_message.dart';

class Chat {
    Chat({
        required this.id,
        required this.blocked,
        required this.regDate,
        required this.lastMessages,
    });

    final int id;
    final bool blocked;
    final String regDate;
    final List<ChatMessage> lastMessages;

    factory Chat.fromJson(Map<String, dynamic> json){ 
        return Chat(
            id: json["id"] ?? 0,
            blocked: json["blocked"] ?? false,
            regDate: json["reg_date"] ?? "",
            lastMessages: json["last_messages"] == null ? [] : List<ChatMessage>.from(json["last_messages"]!.map((x) => ChatMessage.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "blocked": blocked,
        "reg_date": regDate,
        "last_messages": lastMessages.map((x) => x.toJson()).toList(),
    };

}
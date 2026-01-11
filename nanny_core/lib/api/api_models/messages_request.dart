import 'package:nanny_core/nanny_core.dart';

class MessagesRequest implements NannyBaseRequest {
  MessagesRequest(
      {required this.idChat, required this.offset, required this.limit});

  final int idChat;
  final int offset;
  final int limit;

  @override
  Map<String, dynamic> toJson() =>
      {"id_chat": idChat, "offset": offset, "limit": limit};
}

import 'package:nanny_core/api/web_sockets/nanny_web_socket.dart';
import 'package:nanny_core/nanny_core.dart';

class ChatsSocket extends NannyWebSocket{
  @override
  String get address => "${NannyConsts.socketUrl}/chats/${NannyUser.userInfo!.chatToken}";
}
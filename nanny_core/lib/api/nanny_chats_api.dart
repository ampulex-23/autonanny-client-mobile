import 'package:nanny_core/api/api_models/messages_request.dart';
import 'package:nanny_core/api/api_models/search_query_request.dart';
import 'package:nanny_core/api/request_builder.dart';
import 'package:nanny_core/models/from_api/chat.dart';
import 'package:nanny_core/models/from_api/direct_chat.dart';
import 'package:nanny_core/nanny_core.dart';

class NannyChatsApi {
  static Future<ApiResponse<ChatsData>> getChats(SearchQueryRequest request) async {
    return RequestBuilder<ChatsData>().create(
      dioRequest: DioRequest.dio.post("/chats/get_chats", data: request.toJson()),
      onSuccess: (response) => ChatsData.fromJson(response.data),
    );
  }
  static Future<ApiResponse<Chat>> getChat(int id) async {
    var data = <String, dynamic> {
      "id": id,
    };
    return RequestBuilder<Chat>().create(
      dioRequest: DioRequest.dio.post("/chats/get_chat", data: data),
      onSuccess: (response) => Chat.fromJson(response.data),
    );
  }
  static Future<ApiResponse<DirectChat>> getMessages(MessagesRequest request) async {
    return RequestBuilder<DirectChat>().create(
      dioRequest: DioRequest.dio.post("/chats/get_messages", data: request.toJson()),
      onSuccess: (response) => DirectChat.fromJson(response.data),
    );
  }

  // FE-MVP-010: Создание/получение чата с водителем по расписанию
  static Future<ApiResponse<int>> createDriverChat(int scheduleId) async {
    return RequestBuilder<int>().create(
      dioRequest: DioRequest.dio.post("/users/create_driver_chat/$scheduleId"),
      onSuccess: (response) => response.data['chat_id'] as int,
      errorCodeMsgs: {
        404: "Расписание не найдено или водитель еще не назначен",
        403: "Нет доступа к этому расписанию"
      },
    );
  }
}
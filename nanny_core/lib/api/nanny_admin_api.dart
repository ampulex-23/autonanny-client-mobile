import 'package:nanny_core/api/api_models/create_user_request.dart';
import 'package:nanny_core/api/api_models/get_users_request.dart';
import 'package:nanny_core/api/api_models/search_query_request.dart';
import 'package:nanny_core/api/request_builder.dart';
import 'package:nanny_core/models/from_api/other_parametr.dart';
import 'package:nanny_core/models/from_api/table_data.dart';
import 'package:nanny_core/nanny_core.dart';

class NannyAdminApi {
  static Future<ApiResponse<void>> changeBiometrySettings() async {
    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio.get("/admins/change-biometry-settings"),
    );
  }

  static Future<ApiResponse<void>> updateOtherParametr(
      OtherParametr request) async {
    if (request.id == null || request.title == null || request.amount == null)
      throw Exception("Invalid data!");

    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio
          .put("/admins/other-parametrs-of-drive", data: request.toJson()),
    );
  }

  static Future<ApiResponse<void>> createOtherParametr(
      OtherParametr request) async {
    if (request.title == null || request.amount == null)
      throw Exception("Invalid data!");

    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio
          .post("/admins/other-parametrs-of-drive", data: request.toJson()),
    );
  }

  static Future<ApiResponse<void>> deleteOtherParametr(
      OtherParametr request) async {
    if (request.id == null) throw Exception("Id must not be null!");

    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio
          .delete("/admins/other-parametrs-of-drive", data: request.toJson()),
    );
  }

  static Future<ApiResponse<GetUsersData>> getUsers(
      GetUsersRequest request) async {
    return RequestBuilder<GetUsersData>().create(
      dioRequest:
          DioRequest.dio.post("/admins/get_users", data: request.toJson()),
      onSuccess: (response) => GetUsersData.fromJson(response.data),
    );
  }

  static Future<ApiResponse<List<UserInfo>>> getPartners(
      SearchQueryRequest request) async {
    return RequestBuilder<List<UserInfo>>().create(
      dioRequest:
          DioRequest.dio.post("/admins/get_partners", data: request.toJson()),
      onSuccess: (response) => List<UserInfo>.from(
          response.data['partners'].map((x) => UserInfo.fromJson(x))),
    );
  }

  static Future<ApiResponse<UserInfo<Partner>>> getPartner(int id) async {
    var data = <String, dynamic>{
      "id": id,
    };
    return RequestBuilder<UserInfo<Partner>>().create(
      dioRequest: DioRequest.dio.post("/admins/get_partner", data: data),
      onSuccess: (response) =>
          UserInfo.fromJson(response.data['partner']).asPartner(),
    );
  }

  static Future<ApiResponse<UserInfo<Partner>>> getPartnerReferal(
      int id) async {
    var data = <String, dynamic>{
      "id": id,
    };
    return RequestBuilder<UserInfo<Partner>>().create(
      dioRequest:
          DioRequest.dio.post("/admins/get_partners_referal", data: data),
      onSuccess: (response) =>
          UserInfo.fromJson(response.data['data']).asPartner(),
    );
  }

  static Future<ApiResponse<GetUsersData>> banUser(int id) async {
    var data = <String, dynamic>{
      "id": id,
    };
    return RequestBuilder<GetUsersData>().create(
        dioRequest: DioRequest.dio.post("/admins/ban-user", data: data),
        errorCodeMsgs: {
          201: "Такого пользователя не существует!",
        });
  }

  static Future<ApiResponse<GetUsersData>> deleteUser(int id) async {
    var data = <String, dynamic>{
      "id": id,
    };
    return RequestBuilder<GetUsersData>().create(
        dioRequest: DioRequest.dio.post("/admins/delete-user", data: data),
        errorCodeMsgs: {
          201: "Такого пользователя не существует!",
        });
  }

  static Future<ApiResponse<void>> createUser(CreateUserRequest request) async {
    return RequestBuilder<void>().create(
        dioRequest:
            DioRequest.dio.post("/admins/new_user", data: request.toJson()),
        errorCodeMsgs: {
          201: "Пользователь создан, но SMS не удалось отправить",
          404: "Пользователь с таким телефоном уже зарегистрирован!",
        });
  }

  static Future<ApiResponse<List<double>>> getSalesReportGraph(
      {String? startDate, String? endDate}) async {
    return RequestBuilder<List<double>>().create(
      dioRequest: DioRequest.dio.get(
        "/admins/report_sales",
        queryParameters: {
          "start_date": startDate,
          "end_date": endDate,
        },
      ),
      onSuccess: (response) => List<double>.from(response.data["data"] ?? []),
    );
  }

  static Future<ApiResponse<List<NannyTableData>>> getSalesReportTable(
      {String? startDate, String? endDate}) async {
    return RequestBuilder<List<NannyTableData>>().create(
      dioRequest: DioRequest.dio.get(
        "/admins/report_sales",
        queryParameters: {
          "start_date": startDate,
          "end_date": endDate,
        },
      ),
      onSuccess: (response) => List<NannyTableData>.from(
          response.data["data"]?.map((x) => NannyTableData.fromJson(x))),
    );
  }

  static Future<ApiResponse<String>> downloadSalesReport(
      {String? startDate, String? endDate}) async {
    return RequestBuilder<String>().create(
      dioRequest: DioRequest.dio.post(
        "/admins/report_sales",
        queryParameters: {
          "start_date": startDate,
          "end_date": endDate,
        },
      ),
      onSuccess: (response) => response.data,
    );
  }

  static Future<ApiResponse<List<double>>> getUsersReportGraph(
      {String? startDate, String? endDate}) async {
    return RequestBuilder<List<double>>().create(
      dioRequest: DioRequest.dio.get(
        "/admins/report_users",
        queryParameters: {
          "start_date": startDate,
          "end_date": endDate,
        },
      ),
      onSuccess: (response) => List<double>.from(response.data["data"] ?? []),
    );
  }

  static Future<ApiResponse<List<NannyTableData>>> getUsersReportTable(
      {String? startDate, String? endDate}) async {
    return RequestBuilder<List<NannyTableData>>().create(
      dioRequest: DioRequest.dio.get(
        "/admins/report_users",
        queryParameters: {
          "start_date": startDate,
          "end_date": endDate,
        },
      ),
      onSuccess: (response) => List<NannyTableData>.from(
          response.data["data"].map((x) => NannyTableData.fromJson(x))),
    );
  }

  static Future<ApiResponse<String>> downloadUsersReport(
      {String? startDate, String? endDate}) async {
    return RequestBuilder<String>().create(
      dioRequest: DioRequest.dio.post(
        "/admins/report_users",
        queryParameters: {
          "start_date": startDate,
          "end_date": endDate,
        },
      ),
      onSuccess: (response) => response.data,
    );
  }
}

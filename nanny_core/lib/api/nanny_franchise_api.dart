import 'package:nanny_core/api/api_models/create_user_request.dart';
import 'package:nanny_core/api/request_builder.dart';
import 'package:nanny_core/models/from_api/drive_and_map/drive_tariff.dart';
import 'package:nanny_core/models/from_api/drive_and_map/franchise_tariff.dart';
import 'package:nanny_core/models/from_api/my_referals_data.dart';
import 'package:nanny_core/models/from_api/payment_requests.dart';
import 'package:nanny_core/models/from_api/response_new_driver_request.dart';
import 'package:nanny_core/nanny_core.dart';

class NannyFranchiseApi {
  static Future< ApiResponse<List<UserInfo<void>>> > getDrivers() async {
    return RequestBuilder< List<UserInfo<void>> >().create(
      dioRequest: DioRequest.dio.get("/franchises/drivers"),
      onSuccess: (response) => List<UserInfo>.from(response.data['drivers'].map((x) => UserInfo.fromJson(x))),
    );
  }

  static Future< ApiResponse<List<UserInfo<void>>> > getNewDrivers() async {
    return RequestBuilder< List<UserInfo<void>> >().create(
      dioRequest: DioRequest.dio.get("/franchises/get_new_drivers"),
      onSuccess: (response) => List<UserInfo>.from(response.data['drivers'].map((x) => UserInfo.fromJson(x))),
    );
  }

  static Future< ApiResponse<List<UserInfo>> > agreePaymentRequest({
    required int idPayment,
    required int idDriver,
  }) async {
    var data = <String, dynamic> {
      "id_payment": idPayment,
      "id_driver": idDriver
    };
    return RequestBuilder< List<UserInfo> >().create(
      dioRequest: DioRequest.dio.post("/franchises/agree_payment_request", data: data),
    );
  }

  static Future< ApiResponse<MyReferalData> > getMyReferals() async {
    return RequestBuilder<MyReferalData>().create(
      dioRequest: DioRequest.dio.post("/franchises/get-my-referals"),
      onSuccess: (response) => MyReferalData.fromJson(response.data['partner']),
    );
  }

  static Future< ApiResponse<List<PaymentRequests>> > getPaymentRequests() {
    return RequestBuilder<List<PaymentRequests>>().create(
      dioRequest: DioRequest.dio.get("/franchises/get_payment_request"),
      onSuccess: (response) => response.data['result'].map((x) => PaymentRequests.fromJson(x)),
    );
  }

  static Future<ApiResponse<void>> createUser(CreateUserRequest request) async {
    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio.post("/franchises/new_user", data: request.toJson()),
    );
  }

  static Future< ApiResponse<void> > addBonusMoney({required int id, required int amount}) {
    var data = <String, dynamic>{
      "id_driver": id,
      "amount": amount
    };
    
    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio.post("/franchises/add_bonus_money", data: data),
      errorCodeMsgs: {
        404: "Водитель не найден"
      }
    );
  }

  static Future< ApiResponse<void> > addFinemoney({required int id, required int amount}) {
    var data = <String, dynamic>{
      "id_driver": id,
      "amount": amount
    };
    
    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio.post("/franchises/add_fine_money", data: data),
      errorCodeMsgs: {
        404: "Водитель не найден"
      }
    );
  }

  static Future< ApiResponse<List<DriveTariff>> > getTariffs() {
    return RequestBuilder<List<DriveTariff>>().create(
      dioRequest: DioRequest.dio.get("/franchises/tariffs"),
      onSuccess: (response) => List<DriveTariff>.from(response.data["tariffs"].map((x) => DriveTariff.fromJson(x))),
    );
  }

  static Future<ApiResponse<void>> createTariff(FranchiseTariff request) {
    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio.post("/franchises/tariff", data: request.toJson())
    );
  }

  static Future<ApiResponse<void>> deleteTariff(int id) {
    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio.delete("/franchises/tariff?id=$id")
    );
  }

  static Future<ApiResponse<void>> updateTariff(FranchiseTariff data) {
    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio.delete("/franchises/tariff", data: data.toJson())
    );
  }

  static Future<ApiResponse<void>> responseNewDriver(ResponseNewDriverRequest request) {
    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio.post("/franchises/response_new_driver", data: request.toJson()),
      errorCodeMsgs: {
        201: "Пользователь не найден!"
      }
    );
  }

}
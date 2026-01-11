import 'package:nanny_core/api/api_models/add_debit_card_request.dart';
import 'package:nanny_core/api/api_models/add_money_request.dart';
import 'package:nanny_core/api/api_models/base_models/api_response.dart';
import 'package:nanny_core/api/api_models/confirm_payment_request.dart';
import 'package:nanny_core/api/api_models/sos_activate_request.dart';
import 'package:nanny_core/api/api_models/start_payment_request.dart';
import 'package:nanny_core/api/api_models/start_sbp_payment_request.dart';
import 'package:nanny_core/api/api_models/update_me_request.dart';
import 'package:nanny_core/api/dio_request.dart';
import 'package:nanny_core/api/request_builder.dart';
import 'package:nanny_core/models/from_api/check_3ds_data.dart';
import 'package:nanny_core/models/from_api/driver_contact.dart';
import 'package:nanny_core/models/from_api/payment_init_data.dart';
import 'package:nanny_core/models/from_api/sbp_init_data.dart';
import 'package:nanny_core/models/from_api/user_cards.dart';
import 'package:nanny_core/models/from_api/user_info.dart';
import 'package:nanny_core/models/from_api/user_money.dart';

class NannyUsersApi {
  static Future<ApiResponse<UserInfo>> getMe() async {
    return RequestBuilder<UserInfo>().create(
      dioRequest: DioRequest.dio.get("/users/get_me"),
      onSuccess: (response) => UserInfo.fromJson(response.data['me']),
    );
  }

  static Future<ApiResponse<void>> updateMe(UpdateMeRequest request) async {
    return RequestBuilder().create(
      dioRequest:
          DioRequest.dio.put("/users/update_me", data: request.toJson()),
    );
  }

  static Future<ApiResponse<UserMoney>> getMoney({String? period}) async {
    return RequestBuilder<UserMoney>().create(
      dioRequest: DioRequest.dio.post("/users/money?period=$period"),
      onSuccess: (response) => UserMoney.fromJson(response.data),
    );
  }

  static Future<ApiResponse<int>> addDebitCard(
      AddDebitCardRequest request) async {
    return RequestBuilder<int>().create(
        dioRequest: DioRequest.dio
            .post("/users/add_debit_card", data: request.toJson()),
        onSuccess: (response) => response.data['card_id'],
        errorCodeMsgs: {
          404: "Некорректный номер карты!",
          405: "Недопустимый банк карты!",
          406: "Карта уже добавлена!",
          407: "Некорректная дата сгорания карты!",
          408: "Некорректное имя носителя карты!",
        });
  }

  static Future<ApiResponse<PaymentInitData>> startPayment(
      StartPaymentRequest request) async {
    return RequestBuilder<PaymentInitData>().create(
      dioRequest:
          DioRequest.dio.post("/users/start_payment", data: request.toJson()),
      onSuccess: (response) => PaymentInitData.fromJson(response.data),
    );
  }

  static Future<ApiResponse<SbpInitData>> startSbpPayment(
      StartSbpPaymentRequest request) async {
    return RequestBuilder<SbpInitData>().create(
      dioRequest: DioRequest.dio
          .post("/users/start_sbp_payment", data: request.toJson()),
      onSuccess: (response) => SbpInitData.fromJson(response.data['payment']),
    );
  }

  static Future<ApiResponse<Check3DsData>> confirmPayment(
      ConfirmPaymentRequest request) async {
    return RequestBuilder<Check3DsData>().create(
      dioRequest:
          DioRequest.dio.post("/users/confirm_payment", data: request.toJson()),
      onSuccess: (response) => Check3DsData.fromJson(response.data),
    );
  }

  static Future<ApiResponse<UserCards>> getUserCards() async {
    return RequestBuilder<UserCards>().create(
      dioRequest: DioRequest.dio.post("/users/get-my-card"),
      onSuccess: (response) => UserCards.fromJson(response.data),
    );
  }

  static Future<ApiResponse<void>> deleteMyCard({required int id}) async {
    var data = <String, dynamic>{
      "id": id,
    };
    return RequestBuilder().create(
      dioRequest: DioRequest.dio.post("/users/delete-my-card", data: data),
    );
  }

  static Future<ApiResponse<void>> addMoney(AddMoneyRequest request) async {
    return RequestBuilder().create(
        dioRequest:
            DioRequest.dio.post("/users/add_money", data: request.toJson()),
        errorCodeMsgs: {
          402:
              "Не удалось пополнить баланс!\nЕсли деньги с вашей карты снялись, то обратитесь в поддержку."
        });
  }

  // FE-MVP-009: Получение контактов водителя для расписания
  static Future<ApiResponse<DriverContact>> getDriverContact(int scheduleId) async {
    return RequestBuilder<DriverContact>().create(
      dioRequest: DioRequest.dio.get("/users/driver_contact/$scheduleId"),
      onSuccess: (response) => DriverContact.fromJson(response.data['driver']),
      errorCodeMsgs: {
        404: "Водитель еще не назначен на этот контракт"
      },
    );
  }

  // FE-MVP-003: Активация SOS-кнопки
  static Future<ApiResponse<void>> activateSOS(SOSActivateRequest request) async {
    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio.post("/users/activate_sos", data: request.toJson()),
      errorCodeMsgs: {
        400: "Ошибка при активации SOS"
      },
    );
  }
}

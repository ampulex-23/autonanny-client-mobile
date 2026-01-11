import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/api/api_models/driver_payment_request.dart';
import 'package:nanny_core/api/api_models/search_query_request.dart';
import 'package:nanny_core/api/api_models/want_schedule_request.dart';
import 'package:nanny_core/api/request_builder.dart';
import 'package:nanny_core/models/from_api/drive_and_map/driver_schedule_response.dart';
import 'package:nanny_core/models/from_api/drive_and_map/today_schedule_data.dart';
import 'package:nanny_core/models/from_api/roles/driver_referal_data.dart';
import 'package:nanny_core/nanny_core.dart';

class NannyDriverApi {
  static Future< ApiResponse<DriverUserTextData> > getDriver(int id) async {
    var data = <String, dynamic>{
      "id": id,
    };
    
    return RequestBuilder<DriverUserTextData>().create(
      dioRequest: DioRequest.dio.post<DriverUserTextData>('/drivers/get_driver', data: data),
      onSuccess: (response) => DriverUserTextData.fromJson(response.data),
    );
  }

  static Future< ApiResponse<List<DriverReferalData>> > getMyReferals({int offset = 0, int limit = 30}) async {
    var data = {
      "offfset": offset,
      "limit": limit
    };
    return RequestBuilder<List<DriverReferalData>>().create(
      dioRequest: DioRequest.dio.get("/drivers/get-my-referals", data: data),
      onSuccess: (response) => List<DriverReferalData>.from(response.data["referals"].map((x) => DriverReferalData.fromJson(x))),
    );
  }

  static Future< ApiResponse<String> > startDriveMode(LatLng loc) async {
    var data = {
      "latitude": loc.latitude,
      "longitude": loc.longitude
    };
    return RequestBuilder<String>().create(
      dioRequest: DioRequest.dio.post("/drivers/start-driver-mode", data: data),
      onSuccess: (response) => response.data["driver-token"],
    );
  }

  static Future<ApiResponse<void>> requestPayment(DriverPaymentRequest request) async {
    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio.post("/drivers/request-payment", data: request.toJson()),
    );
  }

  static Future< ApiResponse<List<DriverScheduleResponse>> > getScheduleRequests(SearchQueryRequest request) async {
    return RequestBuilder<List<DriverScheduleResponse>>().create(
      dioRequest: DioRequest.dio.get("/drivers/get_schedules_requests?limit=${request.limit}&offset=${request.offset}"),
      onSuccess: (response) => List<DriverScheduleResponse>.from(response.data["schedules"].map((x) => DriverScheduleResponse.fromJson(x))),
    );
  }

  static Future< ApiResponse<List<TodayScheduleData>> > getTodaySchedules() async {
    return RequestBuilder<List<TodayScheduleData>>().create(
      dioRequest: DioRequest.dio.get("/drivers/get_today_schedule"),
      onSuccess: (response) => List<TodayScheduleData>.from(response.data["schedule"].map((x) => TodayScheduleData.fromJson(x))),
    );
  }

  static Future< ApiResponse<void>> wantScheduleRequest(WantScheduleRequest request) async {
    return RequestBuilder<void>().create(
      dioRequest: DioRequest.dio.post("/drivers/want_schedule_requests", data: request.toJson())
    );
  }
}

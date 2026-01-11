import 'package:nanny_core/api/api_models/car_model_data.dart';
import 'package:nanny_core/api/api_models/static_data.dart';
import 'package:nanny_core/api/request_builder.dart';
import 'package:nanny_core/models/from_api/drive_and_map/drive_tariff.dart';
import 'package:nanny_core/models/from_api/other_parametr.dart';
import 'package:nanny_core/nanny_core.dart';

class NannyStaticDataApi {
  static Future< ApiResponse<List<DriveTariff>> > getTariffs() {
    return RequestBuilder<List<DriveTariff>>().create(
      dioRequest: DioRequest.dio.get("/static-data/tariffs"),
      onSuccess: (response) => List<DriveTariff>.from(response.data["tariffs"].map((x) => DriveTariff.fromJson(x))),
    );
  }

  static Future<ApiResponse<bool>> getBiometricSettings() {
    return RequestBuilder<bool>().create(
      dioRequest: DioRequest.dio.post("/static-data/get-biometric-settings"),
      onSuccess: (response) => response.data['value'],
      defaultErrorMsg: "Не удалось проверить возможность авторизации по биометрии!"
    );
  }
  
  static Future<ApiResponse<List<OtherParametr>>> getOtherParams() {
    return RequestBuilder<List<OtherParametr>>().create(
      dioRequest: DioRequest.dio.get("/static-data/other-parametrs-of-drive"),
      onSuccess: (response) => List<OtherParametr>.from(response.data['data'].map((e) => OtherParametr.fromJson(e))),
    );
  }
  
  static Future<ApiResponse<List<StaticData>>> getCities(StaticData? request) {
    return RequestBuilder<List<StaticData>>().create(
      dioRequest: DioRequest.dio.get("/static-data/city/${request?.toGetQuery() ?? ''}"),
      onSuccess: (response) => List<StaticData>.from(response.data['cities'].map((x) => StaticData.fromJson(x))),
    );
  }

  static Future<ApiResponse<List<StaticData>>> getCountries(StaticData? request) {
    return RequestBuilder<List<StaticData>>().create(
      dioRequest: DioRequest.dio.get("/static-data/country/${request?.toGetQuery() ?? ''}"),
      onSuccess: (response) => List<StaticData>.from(response.data['countries'].map((x) => StaticData.fromJson(x))),
    );
  }

  static Future<ApiResponse<List<StaticData>>> getColors(StaticData? request) {
    return RequestBuilder<List<StaticData>>().create(
      dioRequest: DioRequest.dio.get("/static-data/color/${request?.toGetQuery() ?? ''}"),
      onSuccess: (response) => List<StaticData>.from(response.data['colors'].map((x) => StaticData.fromJson(x))),
    );
  }

  static Future<ApiResponse<List<StaticData>>> getCarMarks(StaticData? request) {
    return RequestBuilder<List<StaticData>>().create(
      dioRequest: DioRequest.dio.get("/static-data/car-mark/${request?.toGetQuery() ?? ''}"),
      onSuccess: (response) => List<StaticData>.from(response.data['marks'].map((x) => StaticData.fromJson(x))),
    );
  }

  static Future<ApiResponse<List<CarModelData>>> getCarModels(CarModelData? request) {
    return RequestBuilder<List<CarModelData>>().create(
      dioRequest: DioRequest.dio.get("/static-data/car-model/${request?.toGetQuery() ?? ''}"),
      onSuccess: (response) => List<CarModelData>.from(response.data['models'].map((x) => CarModelData.fromJson(x))),
    );
  }
  
}
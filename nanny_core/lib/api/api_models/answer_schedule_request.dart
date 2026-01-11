import 'package:nanny_core/api/api_models/base_models/base_request.dart';

class AnswerScheduleRequest implements NannyBaseRequest {
  AnswerScheduleRequest({
    this.idSchedule,
    this.idResponse,
    this.flag
  });

  int? idSchedule;
  int? idResponse;
  bool? flag;
  
  @override
  Map<String, dynamic> toJson() => {
    "id_schedule": idSchedule,
    "id_response": idResponse,
    "flag": flag
  };
}
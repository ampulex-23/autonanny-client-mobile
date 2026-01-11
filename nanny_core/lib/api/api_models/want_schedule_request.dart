import 'package:nanny_core/nanny_core.dart';

class WantScheduleRequest implements NannyBaseRequest {
  WantScheduleRequest();

  int idSchedule = 0;
  List<int> idRoads = [];
  
  @override
  Map<String, dynamic> toJson() => {
    "id_schedule": idSchedule,
    "id_road": idRoads
  };
}
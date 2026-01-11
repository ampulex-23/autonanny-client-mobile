import 'package:nanny_core/constants.dart';
import 'package:nanny_core/models/from_api/drive_and_map/drive_tariff.dart';
import 'package:nanny_core/models/from_api/drive_and_map/schedule.dart';
import 'package:nanny_core/models/from_api/other_parametr.dart';

class DriverScheduleResponse extends Schedule {
  DriverScheduleResponse({
    required super.title,
    required super.duration,
    required super.childrenCount,
    required super.weekdays,
    required super.tariff,
    required super.otherParametrs,
    required super.roads,
    required this.user,
    required this.allSalary,
    required super.datetimeCreate,
  });

  ScheduleUser user;
  int allSalary;

  DriverScheduleResponse.fromJson(Map<String, dynamic> json)
      : user = ScheduleUser.fromJson(json["user"]),
        allSalary = json["all_salary"],
        super(
          id: json["id"],
          title: json["title"] ?? "",
          description: json["description"] ?? "",
          duration: json["duration"] ?? 0,
          childrenCount: json["children_count"] ?? 0,
          weekdays: json["week_days"] == null
              ? []
              : List<NannyWeekday>.from(
                  json["week_days"].map((x) => NannyWeekday.values[x])),
          tariff: DriveTariff(id: json["id_tariff"]),
          otherParametrs: json["other_parametrs"] == null
              ? []
              : List<OtherParametr>.from(json["other_parametrs"]!
                  .map((x) => OtherParametr.fromJson(x))),
          roads: json["roads"] == null
              ? []
              : List<Road>.from(json["roads"]!.map((x) => Road.fromJson(x))),
          salary: json["salary"],
          datetimeCreate: DateTime.parse(json["datetime_create"]),
        );
}

class ScheduleUser {
  ScheduleUser(
      {required this.idUser, required this.name, required this.photoPath});

  int idUser;
  String name;
  String photoPath;

  factory ScheduleUser.fromJson(Map<String, dynamic> json) {
    String photo = json["photo_path"]
        .replaceAll("https://77.232.137.74:5000/api/v1.0", NannyConsts.baseUrl);

    return ScheduleUser(
        idUser: json["id_user"], name: json["name"], photoPath: photo);
  }
}

import 'package:nanny_core/models/from_api/drive_and_map/schedule.dart';

class ScheduleResponsesData {
  ScheduleResponsesData({
    required this.id,
    required this.idDriver,
    required this.name,
    required this.photoPath,
    required this.idSchedule,
    required this.idChat,
    this.fullTime = true,
    required this.data,
    this.schedule,
  });

  final int id;
  final int idDriver;
  final String name;
  final String photoPath;
  final int idSchedule;
  Schedule? schedule;
  final int idChat;
  final bool fullTime;
  final List<ResponseRoadData> data;

  factory ScheduleResponsesData.fromJson(Map<String, dynamic> json) {
    return ScheduleResponsesData(
      id: json["id"] ?? 0,
      idDriver: json["id_driver"] ?? 0,
      name: json["name"] ?? "",
      photoPath: json["photo_path"] ?? "",
      idSchedule: json["id_schedule"] ?? 0,
      idChat: json["id_chat"] ?? 0,
      fullTime: json["full_time"] ?? true,
      data: json["data"] == null
          ? []
          : List<ResponseRoadData>.from(
              json["data"]!.map((x) => ResponseRoadData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_driver": idDriver,
        "name": name,
        "photo_path": photoPath,
        "id_schedule": idSchedule,
        "id_chat": idChat,
        "full_time": fullTime,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class ResponseRoadData {
  ResponseRoadData({
    required this.idRoad,
    required this.weekDay,
  });

  final int idRoad;
  final int weekDay;

  factory ResponseRoadData.fromJson(Map<String, dynamic> json) {
    return ResponseRoadData(
      idRoad: json["id_road"] ?? 0,
      weekDay: json["week_day"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id_road": idRoad,
        "week_day": weekDay,
      };
}

/*
[
	{
		"id": 8,
		"id_driver": 21,
		"name": "Максим",
		"photo_path": "https://nyanyago.ru/api/v1.0/files/ce000f99-0587-406f-b729-cdbf1734606bcb6b2145-9e78-44ea-a0b1-a65d8beb24431705858226.6092051000026977.jpg",
		"id_schedule": 9,
		"id_chat": 13,
		"data": [
			{
				"id_road": 17,
				"week_day": 0
			}
		]
	}
]*/
import 'package:nanny_core/nanny_core.dart';

class TodayScheduleData {
    TodayScheduleData({
        required this.id,
        required this.title,
        required this.parentName,
        required this.idParent,
        required this.time,
        required this.date,
    });

    final int id;
    final String title;
    final String parentName;
    final int idParent;
    final String time;
    final DateTime date;

    factory TodayScheduleData.fromJson(Map<String, dynamic> json){ 
        return TodayScheduleData(
            id: json["id"] ?? 0,
            title: json["title"] ?? "",
            parentName: json["parent_name"] ?? "",
            idParent: json["id_parent"] ?? 0,
            time: json["time"] ?? "",
            date: json["date"] == null ? DateTime(0) : DateFormat("dd.MM.yyyy").parse(json["date"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "parent_name": parentName,
        "id_parent": idParent,
        "time": time,
        "date": DateFormat("dd.MM.yyyy").format(date),
    };

}

/*
{
	"id": 0,
	"title": "string",
	"parent_name": "string",
	"id_parent": 0,
	"time": "12:00 - 15:50",
	"date": "03.04.2024"
}*/
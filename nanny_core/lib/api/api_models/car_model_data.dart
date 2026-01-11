import 'package:nanny_core/api/api_models/static_data.dart';

class CarModelData extends StaticData {
  CarModelData({
    super.id,
    super.title,
    this.carMarkId,
    this.releaseYear,
  });

  final int? carMarkId;
  final int? releaseYear;

  CarModelData.fromJson(Map<String, dynamic> json)
    : carMarkId = json['id_car_mark'],
      releaseYear = json['releaseYear'],
      super.fromJson(json);

  @override
  String toGetQuery() {
    if(carMarkId != null && title.isNotEmpty) return "?id_mark=$carMarkId&title=$title";
    if(carMarkId != null) return "?id_mark=$carMarkId";
    return super.toGetQuery();
  }
}
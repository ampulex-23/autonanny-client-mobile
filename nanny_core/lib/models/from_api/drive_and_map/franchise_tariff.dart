import 'package:nanny_core/api/api_models/base_models/base_request.dart';

class FranchiseTariff implements NannyBaseRequest {
  FranchiseTariff({
    this.id,
    this.title,
    this.description,
    this.photoPath,
    this.percent,
    this.amount,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? photoPath;
  final double? percent;
  final double? amount;

  FranchiseTariff.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      title = json["title"],
      description = json["description"],
      photoPath = json["photo_path"],
      percent = json["percent"],
      amount = json["amount"];
      
  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "photo_path": photoPath,
    "percent": percent,
    "amount": amount
  };
}

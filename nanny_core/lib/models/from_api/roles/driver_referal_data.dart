class DriverReferalData {
  DriverReferalData({
    required this.id,
    required this.name,
    required this.photoPath,
    required this.status
  });

  final int id;
  final String name;
  final String photoPath;
  final bool status;

  DriverReferalData.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      name = json["name"],
      photoPath = json["photo_path"],
      status = json["status"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo_path": photoPath,
    "status": status
  };
}

// {
//   "id": 0,
//   "name": "string",
//   "photo_path": "string",
//   "status": true
// }
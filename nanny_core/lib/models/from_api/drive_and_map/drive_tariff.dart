class DriveTariff {
  DriveTariff({
    required this.id,
    String? title,
    this.photoPath,
    this.amount,
    this.isAvailable = false,
  }) : title = title ?? getDriverTariff(id);

  final int id;
  final String? title;
  final String? photoPath;
  double? amount;
  final bool isAvailable;

  DriveTariff.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? json["id_tariff"],
        title =
            json["title"] ?? getDriverTariff(json["id"] ?? json["id_tariff"]),
        photoPath = json["photo_path"],
        isAvailable = json["isAvailable"] ?? false,
        amount = json["amount"];
}

String getDriverTariff(int tariffId) {
  switch (tariffId) {
    case 1:
      return 'Эконом';
    case 2:
      return 'Комфорт';
    case 3:
      return 'Комфорт +';
    case 4:
      return 'Бизнес';
    case 5:
      return 'Минивэн';
    default:
      return 'Неизвестный тариф';
  }
}

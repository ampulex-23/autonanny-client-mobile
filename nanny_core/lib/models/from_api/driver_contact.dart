class DriverContact {
  DriverContact({
    required this.id,
    required this.name,
    required this.surname,
    this.patronymic,
    required this.phone,
    this.photo,
    this.car,
    this.experienceYears,
    this.rating,
    this.totalTrips,
    this.reviewsCount,
  });

  final int id;
  final String name;
  final String surname;
  final String? patronymic;
  final String phone;
  final String? photo;
  final CarInfo? car;
  final int? experienceYears; // Опыт работы в годах
  final double? rating; // Рейтинг от 0 до 5
  final int? totalTrips; // Общее количество поездок
  final int? reviewsCount; // Количество отзывов

  String get fullName {
    if (patronymic != null && patronymic!.isNotEmpty) {
      return '$surname $name $patronymic';
    }
    return '$surname $name';
  }

  factory DriverContact.fromJson(Map<String, dynamic> json) {
    return DriverContact(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      patronymic: json['patronymic'],
      phone: json['phone'],
      photo: json['photo'],
      car: json['car'] != null ? CarInfo.fromJson(json['car']) : null,
      experienceYears: json['experience_years'],
      rating: json['rating']?.toDouble(),
      totalTrips: json['total_trips'],
      reviewsCount: json['reviews_count'],
    );
  }
}

class CarInfo {
  CarInfo({
    this.mark,
    this.model,
    this.color,
    this.number,
    this.year,
  });

  final String? mark;
  final String? model;
  final String? color;
  final String? number;
  final int? year;

  String get fullInfo {
    List<String> parts = [];
    if (mark != null) parts.add(mark!);
    if (model != null) parts.add(model!);
    if (year != null) parts.add(year.toString());
    return parts.join(' ');
  }

  String get colorAndNumber {
    List<String> parts = [];
    if (color != null) parts.add(color!);
    if (number != null) parts.add(number!);
    return parts.join(', ');
  }

  factory CarInfo.fromJson(Map<String, dynamic> json) {
    return CarInfo(
      mark: json['mark'],
      model: json['model'],
      color: json['color'],
      number: json['number'],
      year: json['year'],
    );
  }
}

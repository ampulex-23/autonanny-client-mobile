
class CurrentOrderInfo {
  final bool status;
  final String message;
  final List<Order> orders;

  CurrentOrderInfo(
      {required this.status, required this.message, required this.orders});

  factory CurrentOrderInfo.fromJson(Map<String, dynamic> json) {
    return CurrentOrderInfo(
        status: json["status"],
        message: json["message"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))));
  }
}

class Order {
  final int? idUser;
  final int? idOrder;
  final String? username;
  final String? phone;
  final String? userPhoto;
  final double? amount;
  final int? idStatus;
  final List<Address> addresses;

  Order(
      {required this.idUser,
        required this.idOrder,
        required this.username,
        required this.phone,
        required this.userPhoto,
        required this.amount,
        required this.idStatus,
        this.addresses = const []});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        idUser: json["id_user"],
        idOrder: json["id_order"],
        username: json["username"],
        phone: json["phone"],
        userPhoto: json["user_photo"],
        amount: json["amount"],
        idStatus: json["id_status"],
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))));
  }
}

class Address {
  final String? from;
  final String? to;
  final double? fromLat;
  final double? fromLon;
  final double? toLat;
  final double? toLon;
  final int? duration;
  final bool? isFinish;

  Address(
      {required this.from,
        required this.to,
        required this.fromLat,
        required this.fromLon,
        required this.toLat,
        required this.toLon,
        required this.duration,
        this.isFinish});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        from: json["from"],
        to: json["to"],
        fromLat: json["from_lat"],
        fromLon: json["from_lon"],
        toLat: json["to_lat"],
        toLon: json["to_lon"],
        duration: json["duration"],
        isFinish: json["is_finish"]);
  }
}

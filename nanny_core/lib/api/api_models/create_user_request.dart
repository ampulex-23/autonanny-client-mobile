import 'package:nanny_core/nanny_core.dart';

class CreateUserRequest implements NannyBaseRequest {
  CreateUserRequest({
    required this.phone,
    required this.password,
    this.name,
    this.surname,
    required this.role,
    this.referalCode,
    this.idCity,
  });

  final String phone;
  final String password;
  final String? name;
  final String? surname;
  final String? referalCode;
  final List<int>? idCity;
  final int role;

  @override
  Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
        "role": role,
        "surname": surname,
        "name": name,
        "referal_code": referalCode,
        "id_city": idCity,
      };
}

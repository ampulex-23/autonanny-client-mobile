import 'package:nanny_core/api/api_models/base_models/base_request.dart';

class NewUserRequest implements NannyBaseRequest {
  NewUserRequest({
    required this.phone,
    required this.password,
    required this.role,
    required this.surname,
    required this.name,
    required this.referalCode
  });

  final String phone;
  final String password;
  final int role;
  final String surname;
  final String name;
  final String referalCode;
  
  @override
  Map<String, dynamic> toJson() => {
    "phone": phone,
    "password": password,
    "role": role,
    "surname": surname,
    "name": name,
    "referal_code": referalCode,
  };

}
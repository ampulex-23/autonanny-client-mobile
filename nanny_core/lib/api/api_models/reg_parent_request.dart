import 'package:nanny_core/nanny_core.dart';

class RegParentRequest implements NannyBaseRequest {
  RegParentRequest({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
  });

  final String firstName;
  final String lastName;
  final String phone;
  late final String password;
  
  @override
  Map<String, dynamic> toJson() => {
    "surname": lastName,
    "name": firstName,
    "phone": phone,
    "password": password
  };
  
}
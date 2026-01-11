import 'package:nanny_core/nanny_core.dart';

class VerifyPassResetRequest implements NannyBaseRequest {
  VerifyPassResetRequest({
    required this.phone,
    required String password
  }) {
    this.password = Md5Converter.convert(password);
  }

  final String phone;
  late final String password;
  
  @override
  Map<String, dynamic> toJson() => {
    "phone": phone,
    "password": password,
  };

}
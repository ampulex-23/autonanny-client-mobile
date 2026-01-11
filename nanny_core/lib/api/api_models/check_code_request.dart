import 'package:nanny_core/nanny_core.dart';

class CheckCodeRequest implements NannyBaseRequest {
  CheckCodeRequest({
    required this.phone,
    required this.code
  });

  final String phone;
  final String code;
  
  @override
  Map<String, dynamic> toJson() => {
    "phone": phone,
    "code": code,
  };
}
import 'package:nanny_core/nanny_core.dart';

class StartSbpPaymentRequest implements NannyBaseRequest {
  StartSbpPaymentRequest({
    required this.amount,
    required this.email,
    required this.phone
  });

  final int amount;
  final String email;
  final String phone;
  
  @override
  Map<String, dynamic> toJson() => {
    "amount": amount,
    "email": email,
    "phone": phone
  };
}
import 'package:nanny_core/api/api_models/base_models/base_request.dart';

class StartPaymentRequest implements NannyBaseRequest {
  StartPaymentRequest({
    required this.ip,
    required this.amount,
    required this.cardData,
    required this.email,
    required this.phone,
    this.recurrent = "N"
  });

  final String ip;
  final int amount;
  final String cardData;
  final String email;
  final String phone;
  final String recurrent;
  
  @override
  Map<String, dynamic> toJson() => {
    "ip": ip,
    "amount": amount,
    "card_data": cardData,
    "email": email,
    "phone": phone,
    "recurrent": recurrent,
  };
}
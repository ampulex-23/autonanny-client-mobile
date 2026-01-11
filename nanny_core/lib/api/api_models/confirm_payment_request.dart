import 'package:nanny_core/nanny_core.dart';

class ConfirmPaymentRequest implements NannyBaseRequest {
  ConfirmPaymentRequest({
    required this.paymentId,
    required this.data,
    required this.email
  });

  final int paymentId;
  final Map<String, String> data;
  final String email;
  
  @override
  Map<String, dynamic> toJson() => {
    "PaymentId": paymentId,
    "DATA": data,
    "email": email
  };

}
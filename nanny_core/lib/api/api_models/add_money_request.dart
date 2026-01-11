import 'package:nanny_core/nanny_core.dart';

class AddMoneyRequest implements NannyBaseRequest {
  AddMoneyRequest({
    required this.amount,
    required this.paymentId
  });

  final int amount;
  final int paymentId;
  
  @override
  Map<String, dynamic> toJson() => {
    "amount": amount,
    "payment_id": paymentId,
  };
}
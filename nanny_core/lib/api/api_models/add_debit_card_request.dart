import 'package:nanny_core/api/api_models/base_models/base_request.dart';

class AddDebitCardRequest implements NannyBaseRequest {
  AddDebitCardRequest({
    required this.cardNumber,
    required this.expDate,
    required this.name
  });

  final String cardNumber;
  final String expDate;
  final String name;
  
  @override
  Map<String, dynamic> toJson() => {
    "card_number": cardNumber,
    "exp_date": expDate,
    "name": name,
  };
}
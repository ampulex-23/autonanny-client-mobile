class DriverPaymentRequest {
  DriverPaymentRequest({
    required this.typeRequest,
    required this.idCard,
    required this.amount
  });

  final int typeRequest;
  final int idCard;
  final double amount;

  DriverPaymentRequest.fromJson(Map<String, dynamic> json) 
    : typeRequest = json["type_request"],
      idCard = json["id_card"],
      amount = json["amount"];

  Map<String, dynamic> toJson() => {
    "type_request": typeRequest,
    "id_card": idCard,
    "amount": amount
  };
}

// {
//   "type_request": 1,
//   "id_card": 0,
//   "amount": 0
// }
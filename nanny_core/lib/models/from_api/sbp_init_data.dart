class SbpInitData {
  final String paymentId;
  final String paymentUrl;
  final int amount;
  
  SbpInitData.fromJson(Map<String, dynamic> json)
    : paymentId = json['PaymentId'] ?? "",
      paymentUrl = json['payment_url'] ?? "",
      amount = json['amount'] ?? 0;
}
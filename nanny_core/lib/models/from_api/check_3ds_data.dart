class Check3DsData {
  const Check3DsData({
    required this.terminalKey,
    required this.is3DsVersion2,
    required this.acsUrl,
    required this.md,
    required this.paReq,
    this.serverTransId,
    this.acsTransId,
    this.paymentId
  });

  Check3DsData.fromJson(Map<String, dynamic> json)
    : terminalKey = json['TerminalKey'],
      is3DsVersion2 = json['is3DsVersion2'],
      serverTransId = json['serverTransId'],
      acsUrl = json['acsUrl'],
      md = json['md'],
      paReq = json['paReq'],
      acsTransId = json['acsTransId'],
      paymentId = int.tryParse(json['PaymentId'] ?? "");

  final String terminalKey;
  final int? paymentId;
  final bool is3DsVersion2;
  final String? serverTransId;
  final String acsUrl;
  final String? md;
  final String? paReq;
  final String? acsTransId;
}
import 'package:nanny_core/nanny_core.dart';

class Partner {
  Partner({
    required this.referalCode,
    required this.referalPercent,
    required this.referals
  });
  final String referalCode;
  final int referalPercent;
  List<UserInfo> referals;

  Partner.fromJson(Map<String, dynamic> json)
    : referalCode = json['referal_code'] ?? "",
      referalPercent = json['referal_percent'] ?? json['partner_percent'] ?? 0,
      referals = json['referals'] == null ? [] : List<UserInfo>.from(json['referals'].map((x) => UserInfo.fromJson(x)));
}
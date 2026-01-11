import 'package:flutter/services.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/api/api_models/search_query_request.dart';
import 'package:nanny_core/nanny_core.dart';

class PartnerInfoVM extends ViewModelBase {
  PartnerInfoVM({
    required super.context, 
    required super.update,
    required this.partnerId,
  }) {
    request = NannyAdminApi.getPartner(partnerId);
  }

  final int partnerId;
  late Future<ApiResponse<UserInfo<Partner>>> request;

  void savePercent() {

  }

  void copyCode(String code) => Clipboard.setData(ClipboardData(text: code));
  
  void listSwitch(bool isReferals) => update(() => showReferals = isReferals);

  bool showReferals = true;

  Future<ApiResponse< List<UserInfo> >> getReferals() => NannyAdminApi.getPartners(
    SearchQueryRequest()
  );
}
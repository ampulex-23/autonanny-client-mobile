import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/admin_part/views/partner_info.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/api/api_models/search_query_request.dart';
import 'package:nanny_core/nanny_core.dart';

class ReferralProgramVm extends ViewModelBase {
  ReferralProgramVm({
    required super.context,
    required super.update,
  }) {
    delayer = SearchDelayer(
      delay: const Duration(seconds: 1),
      initRequest: NannyAdminApi.getPartners(SearchQueryRequest()),
      update: () => update(() {}),
    );
  }

  late SearchDelayer<List<UserInfo>> delayer;
  SearchQueryRequest query = SearchQueryRequest();

  void updateRequestWithDelay() => delayer.wait(
        onCompleteRequest: NannyAdminApi.getPartners(query),
      );

  void updateRequest() =>
      delayer.updateRequest(NannyAdminApi.getPartners(query));

  void search(String text) {
    // Проверка, что длина текста для поиска не менее 3 символов
    if (text.length < 3) {
      return; // Если меньше 3 символов, выходим и не делаем запрос
    }

    query = query.copyWith(
      search: text,
    );
    updateRequestWithDelay();
  }

  void navigateToPartner(int id) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PartnerInfoView(partnerId: id)),
      );
}

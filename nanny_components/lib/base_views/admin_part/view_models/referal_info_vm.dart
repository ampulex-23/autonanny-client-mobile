import 'package:nanny_components/view_model_base.dart';
import 'package:nanny_core/nanny_core.dart';

class ReferalInfoVM extends ViewModelBase {
  ReferalInfoVM({
    required super.context, 
    required super.update,
    required int referalId
  }) {
    request = NannyAdminApi.getPartnerReferal(referalId);
  }

  late Future< ApiResponse<UserInfo<Partner>> > request;
}
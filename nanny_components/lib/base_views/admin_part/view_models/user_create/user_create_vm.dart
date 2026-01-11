import 'package:nanny_components/base_views/admin_part/views/user_create/franchise_create.dart';
import 'package:nanny_components/base_views/admin_part/views/user_create/partner_create.dart';
import 'package:nanny_components/view_model_base.dart';

class UserCreateVM extends ViewModelBase {
  UserCreateVM({
    required super.context, 
    required super.update,
  });

  void toFranchiseCreate() => navigateToView(const FranchiseCreateView());
  void toPartnerCreate() => navigateToView(const PartnerCreateView());
}
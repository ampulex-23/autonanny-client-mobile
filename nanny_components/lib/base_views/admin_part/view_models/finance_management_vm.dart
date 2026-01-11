import 'package:nanny_components/view_model_base.dart';
import 'package:nanny_core/nanny_core.dart';

class FinanceManagementVM extends ViewModelBase {
  FinanceManagementVM({
    required super.context,
    required super.update,
  });

  bool withdrawSelected = false;
  DateType selectedDateType = DateType.day;

  Future<ApiResponse<UserMoney>> get getMoney => _moneyRequest;
  Future<ApiResponse<UserMoney>> _moneyRequest =
      NannyUsersApi.getMoney(period: 'current_day');
  void updateState() => update(() {
        _moneyRequest = NannyUsersApi.getMoney(period: getPeriod());
      });

  void statsSwitch({required bool switchToWithdraw}) {
    withdrawSelected = switchToWithdraw;
    updateState();
  }

  void onDateTypeSelect(DateType? type) {
    selectedDateType = type!;
    updateState();
  }

  String formatCurrency(double balance) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    String formatted =
        formatter.format(balance).replaceAll(',', ' ').replaceAll('.', ', ');
    return "$formatted Р";
  }

  String getPeriod() {
    switch (selectedDateType) {
      case DateType.day:
        return 'current_day';
      case DateType.week:
        return 'current_week';
      case DateType.month:
        return 'current_month';
      case DateType.year:
        return 'current_year';
      default:
        return 'current_day';
    }
  }
}

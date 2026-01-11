import 'package:nanny_components/dialogs/loading.dart';
import 'package:nanny_components/view_model_base.dart';
import 'package:nanny_core/api/api_models/get_users_request.dart';
import 'package:nanny_core/api/nanny_orders_api.dart';
import 'package:nanny_core/models/from_api/drive_and_map/schedule.dart';
import 'package:nanny_core/nanny_core.dart';

class OrderManagementVM extends ViewModelBase {
  // TODO: Изменить под заказы!
  String status = "Не задано";

  OrderManagementVM({required super.context, required super.update}) {
    delayer = SearchDelayer<List<Schedule>>(
      delay: const Duration(seconds: 1),
      initRequest: NannyOrdersApi.getSchedules(),
      update: () => update(() {}),
    );
  }

  GetUsersRequest query = GetUsersRequest(statuses: [""]);
  late final SearchDelayer<List<Schedule>> delayer;

  void resendRequestWithDelay() => delayer.wait(
        onCompleteRequest: NannyOrdersApi.getSchedules(),
      );

  void resendRequest() => delayer.updateRequest(NannyOrdersApi.getSchedules());

  void changeFilter(String value) {
    status = value;
    query = query.copyWith(
      statuses: [value],
    );
    resendRequest();
  }

  void search(String text) {
    if (text.length >= 3) {
      query = query.copyWith(
        search: text,
      );
      resendRequestWithDelay();
    } else if (text.isEmpty) {
      query = query.copyWith(
        search: "",
      );
      resendRequest();
    }
    //if (text.length < 3) {
    //  // Очищаем поисковый запрос, если символов меньше трех
    //  query = query.copyWith(search: null);
    //  delayer.clear(); // Отменяем запросы, если они запланированы
    //  return;
    //}
//
    //query = query.copyWith(search: text);
    //resendRequestWithDelay();
  }

  void banUser(UserInfo user) async {
    LoadScreen.showLoad(context, true);

    bool success = await DioRequest.handleRequest(
      context,
      NannyAdminApi.banUser(user.id),
    );

    if (!success) return;
    if (!context.mounted) return;

    LoadScreen.showLoad(context, false);
    resendRequest();
  }

  void deleteOrder(Schedule sched) async {
    LoadScreen.showLoad(context, true);

    bool success = await DioRequest.handleRequest(
      context,
      NannyOrdersApi.deleteScheduleById(sched.id!),
    );

    if (!success) return;
    if (!context.mounted) return;

    LoadScreen.showLoad(context, false);
    resendRequest();
  }
}

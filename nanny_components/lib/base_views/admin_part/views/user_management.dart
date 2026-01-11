import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/admin_part/view_models/user_management_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class UserManagementView extends StatefulWidget {
  const UserManagementView({super.key});

  @override
  State<UserManagementView> createState() => _UserManagementViewState();
}

class _UserManagementViewState extends State<UserManagementView> {
  late UserManagementVM vm;

  List<DropdownMenuData<String>> items = [
    DropdownMenuData(title: "Не задано", value: ""),
    DropdownMenuData(title: "По дате ↑", value: "По дате ↑"),
    DropdownMenuData(title: "По дате ↓", value: "По дате ↓"),
    DropdownMenuData(title: "Активен", value: "Активен"),
    DropdownMenuData(title: "Не активен", value: "Не активен"),
  ];

  @override
  void initState() {
    super.initState();
    vm = UserManagementVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NannyAppBar(
        title: "Управление пользователями",
        isTransparent: false,
        color: NannyTheme.secondary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Align(
            alignment: Alignment.centerLeft,
            child: DropdownButton(
              elevation: 1,
              dropdownColor: NannyTheme.secondary,
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.only(left: 16, bottom: 0),
              underline: Container(),
              value: vm.query.statuses.first,
              items: items
                  .map((e) => DropdownMenuItem(
                        value: e.value,
                        child: Text(
                          e.title,
                          style: const TextStyle(
                              color: NannyTheme.onSecondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1),
                        ),
                      ))
                  .toList(),
              onChanged: (value) => vm.changeFilter(value!),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 16, left: 16),
        child: Column(
          children: [
            NannyTextForm(
              style: NannyTextFormStyles.searchForm,
              hintText: "Поиск",
              onChanged: (text) => vm.search(text),
            ),
            Expanded(
              child: RequestLoader(
                request: vm.delayer.request,
                completeView: (context, data) {
                  if (vm.delayer.isLoading) return const LoadingView();
                  if (vm.status.isNotEmpty) {
                    if (vm.status == 'Активен') {
                      // Фильтруем только активных пользователей
                      data = data?.copyWith(
                        users: data.users
                            .where((e) => e.status.name == 'Активен')
                            .toList(),
                      );
                    } else if (vm.status == 'Не активен') {
                      // Фильтруем только неактивных пользователей
                      data = data?.copyWith(
                        users: data.users
                            .where((e) => e.status.name != 'Активен')
                            .toList(),
                      );
                    } else if (vm.status == 'По дате ↑') {
                      // Сортировка по дате регистрации (возрастание)
                      data = data?.copyWith(
                        users: data.users.toList()
                          ..sort((a, b) => DateFormat('dd.MM.yyyy')
                              .parse(a.dateReg)
                              .compareTo(
                                  DateFormat('dd.MM.yyyy').parse(b.dateReg))),
                      );
                    } else if (vm.status == 'По дате ↓') {
                      // Сортировка по дате регистрации (убывание)
                      data = data?.copyWith(
                        users: data.users.toList()
                          ..sort((a, b) => DateFormat('dd.MM.yyyy')
                              .parse(b.dateReg)
                              .compareTo(
                                  DateFormat('dd.MM.yyyy').parse(a.dateReg))),
                      );
                    }
                  }

                  return (data?.users ?? []).isEmpty
                      ? const Center(
                          child: Text("Список пуст..."),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => Slidable(
                            endActionPane: ActionPane(
                              extentRatio: .8,
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  flex: 2,
                                  onPressed: (context) =>
                                      vm.banUser(data!.users[index]),
                                  backgroundColor: NannyTheme.darkGrey,
                                  icon: data!.users[index].status ==
                                          UserStatus.active
                                      ? Icons.no_accounts
                                      : Icons.account_circle,
                                  label: data.users[index].status ==
                                          UserStatus.active
                                      ? "Заблокировать"
                                      : "Разблокировать",
                                ),
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (context) =>
                                      vm.deleteUser(data!.users[index]),
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: "Удалить",
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: ProfileImage(
                                  url: data.users[index].photoPath, radius: 50),
                              title: Text(
                                "${data.users[index].name} ${data.users[index].surname}",
                                softWrap: true,
                                style: const TextStyle(
                                    color: NannyTheme.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    height: 17.6 / 16),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  vm.phoneMask.maskText(
                                    data.users[index].phone.substring(1),
                                  ),
                                  style: const TextStyle(
                                      color: Color(0xFF6D6D6D),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      height: 17.6 / 16),
                                ),
                              ),
                              trailing: SizedBox(
                                width: 100,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        data.users[index].role
                                            .map((e) => e.name ==
                                                    "Администратор франшизы"
                                                ? "Франшиза"
                                                : e.name)
                                            .join(',\n'),
                                        style: const TextStyle(
                                            color: NannyTheme.onSecondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            height: 17.6 / 16),
                                        textAlign: TextAlign.end,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 8),
                                    Text(
                                      data.users[index].dateReg,
                                      style: const TextStyle(
                                          color: Color(0xFF6D6D6D),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          height: 17.6 / 16),
                                    ),
                                  ],
                                ),
                              ),
                              tileColor:
                                  data.users[index].status != UserStatus.active
                                      ? Colors.redAccent[100]
                                      : null,
                            ),
                          ),
                          itemCount: data!.users.length,
                          separatorBuilder: (context, index) => Container(
                            height: 1,
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: const Divider(
                                color: NannyTheme.grey,
                                indent: 1,
                                thickness: 1),
                          ),
                        );
                },
                errorView: (context, error) =>
                    ErrorView(errorText: error.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

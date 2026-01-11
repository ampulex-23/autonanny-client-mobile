import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/admin_part/view_models/order_management_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/models/from_api/drive_and_map/drive_tariff.dart';
import 'package:nanny_core/models/from_api/drive_and_map/schedule.dart';
import 'package:nanny_core/nanny_core.dart';

class OrderManagement extends StatefulWidget {
  // TODO: Изменить под заказы!
  const OrderManagement({super.key});

  @override
  State<OrderManagement> createState() => _OrderManagementState();
}

class _OrderManagementState extends State<OrderManagement> {
  late OrderManagementVM vm;

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
    vm = OrderManagementVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NannyAppBar(
        isTransparent: false,
        color: NannyTheme.secondary,
        title: "Управление заказами",
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
              onChanged: (text) => vm.search(text),
            ),
            Expanded(
              child: RequestLoader(
                request: vm.delayer.request,
                completeView: (context, data) {
                  if (vm.delayer.isLoading) return const LoadingView();
                  //List<Schedule>? data = List.generate(
                  //  10,
                  //  (index) => Schedule(
                  //    isActive: false,
                  //    title: '123',
                  //    description: 'Водитель',
                  //    duration: 500,
                  //    childrenCount: 5,
                  //    weekdays: [],
                  //    tariff: DriveTariff(id: 5),
                  //    otherParametrs: [],
                  //    roads: [], datetimeCreate: DateTime(2024, Random().nextInt(12) + 0, Random().nextInt(32) + 0),
                  //  ),
                  //);

                  if (vm.status.isNotEmpty) {
                    if (vm.status == 'По дате ↑') {
                      // Сортировка по дате (возрастание)
                      data?.sort((a, b) =>
                          a.datetimeCreate.compareTo(b.datetimeCreate));
                    } else if (vm.status == 'По дате ↓') {
                      // Сортировка по дате (убывание)
                      data?.sort((a, b) =>
                          b.datetimeCreate.compareTo(a.datetimeCreate));
                    } else if (vm.status == 'Активен') {
                      // Фильтруем только активные элементы
                      data = data?.where((e) => e.isActive == true).toList();
                    } else if (vm.status == 'Не активен') {
                      // Фильтруем только неактивные элементы
                      data = data?.where((e) => e.isActive != true).toList();
                    }
                  }

                  return (data ?? []).isEmpty
                      ? const Center(
                          child: Text("Список пуст..."),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          itemBuilder: (context, index) => data![index].id == -1
                              ? const SizedBox()
                              : Slidable(
                                  endActionPane: ActionPane(
                                    extentRatio: .8,
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                          flex: 2,
                                          onPressed: (context) {},
                                          backgroundColor: NannyTheme.grey,
                                          foregroundColor:
                                              const Color(0xFF212121),
                                          icon: Icons.close,
                                          label: "Отменить"),
                                      SlidableAction(
                                          flex: 1,
                                          onPressed: (context) =>
                                              vm.deleteOrder(
                                                data![index],
                                              ),
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: "Удалить"),
                                    ],
                                  ),
                                  child: ListTile(
                                    //minLeadingWidth: 0,
                                    //minTileHeight: 0,
                                    //minVerticalPadding: 0,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(data[index].title,
                                        style: const TextStyle(
                                            color: NannyTheme.primary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 17.6 / 16),
                                        softWrap: true),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(data[index].description,
                                          style: const TextStyle(
                                              color: Color(0xFF212121),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              height: 17.6 / 16),
                                          softWrap: true),
                                    ),
                                    trailing: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          data[index].tariff.title ?? '',
                                          style: const TextStyle(
                                              color: Color(0xFF2B2B2B),
                                              fontSize: 16,
                                              height: 17.6 / 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 8),
                                        //Text(
                                        //    "Продолжительность: ${data[index].duration.toString()}")
                                        Text(
                                          data[index].isActive == true
                                              ? 'в пути'
                                              : 'завршен',
                                          style: const TextStyle(
                                              color: Color(0xFF6D6D6D),
                                              fontSize: 12,
                                              height: 16.8 / 12,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 1,
                                child: Divider(
                                    color: NannyTheme.grey,
                                    indent: 1,
                                    thickness: 1),
                              ),
                          itemCount: data!.length);
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

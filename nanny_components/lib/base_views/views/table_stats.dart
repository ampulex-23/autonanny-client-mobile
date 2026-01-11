import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/view_models/table_stats_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_components/widgets/states/info_view.dart';
import 'package:nanny_core/constants.dart';

class TableStatsView extends StatefulWidget {
  const TableStatsView({
    super.key,
    required this.getUsersReport,
  });

  final bool getUsersReport;

  @override
  State<TableStatsView> createState() => _TableStatsViewState();
}

class _TableStatsViewState extends State<TableStatsView> {
  late TableStatsVM vm;

  @override
  void initState() {
    super.initState();
    vm = TableStatsVM(
        context: context,
        update: setState,
        getUsersReport: widget.getUsersReport);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NannyAppBar(
          title: "Управление отчетами",
          color: NannyTheme.secondary,
          isTransparent: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          NannyBottomSheet(
            height: 404,
            roundBottom: true,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 41, bottom: 27, left: 16, right: 16),
              child: Column(
                children: [
                  const Text("Отчет о продаже"),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      DateType.values.length,
                      (index) => GestureDetector(
                        onTap: () => vm.onSelect({DateType.values[index]}),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 6, bottom: 6, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: DateType.values[index] == vm.selectedDateType
                                ? NannyTheme.lightGreen
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(49),
                          ),
                          child: Text(
                            DateType.values[index].name,
                            style: const TextStyle(height: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: vm.data.isEmpty
                        ? const InfoView(infoText: "Ещё нет данных")
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final date = vm.getFormattedDates()[index];
                              final price = vm.formatCurrency(vm.data[index]);

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    price,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: NannyTheme.primary),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    date,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: NannyTheme.onSecondary
                                          .withOpacity(.75),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 25,
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: NannyTheme.grey,
                              ),
                            ),
                            itemCount: vm.data.length,
                          ),
                  ),
                  const SizedBox(height: 10),
                  //if (vm.data.isNotEmpty)
                  //  const Align(
                  //    alignment: Alignment.bottomCenter,
                  //    child: Text("Загрузить ещё"),
                  //  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: vm.downloadReport,
              style: const ButtonStyle(
                minimumSize: WidgetStatePropertyAll(
                  Size(double.infinity, 60),
                ),
              ),
              child: const Text("Скачать отчет"),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/view_models/graph_stats_vm.dart';
import 'package:nanny_components/base_views/views/table_stats.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_components/widgets/states/info_view.dart';
import 'package:nanny_core/nanny_core.dart';

class GraphStatsView extends StatefulWidget {
  final String title;
  final bool getUsersReport;

  const GraphStatsView({
    super.key,
    required this.title,
    required this.getUsersReport,
  });

  @override
  State<GraphStatsView> createState() => _GraphStatsViewState();
}

class _GraphStatsViewState extends State<GraphStatsView> {
  late GraphStatsVM vm;

  @override
  void initState() {
    super.initState();
    vm = GraphStatsVM(
        context: context,
        update: setState,
        getUsersReport: widget.getUsersReport);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 28),
          decoration: BoxDecoration(
            color: NannyTheme.onPrimary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: NannyTheme.shadow.withOpacity(.19),
                blurRadius: 32,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.title,
                  style: Theme.of(context).textTheme.titleMedium),
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
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("График"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => vm.navigateToView(
                          TableStatsView(getUsersReport: widget.getUsersReport),
                        ),
                        style: NannyButtonStyles.whiteButton,
                        child: const Text("Таблица"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FutureLoader(
                    future: vm.loadRequest,
                    completeView: (context, data) {
                      if (!data) {
                        return const ErrorView(
                            errorText: "Не удалось загрузить данные!");
                      }
                      return vm.data.isEmpty
                          ? const InfoView(infoText: "Ещё нет данных")
                          : DChartLineN(
                              groupList: [
                                NumericGroup(
                                  id: "1",
                                  data: vm.data
                                      .asMap()
                                      .entries
                                      .map(
                                        (e) => NumericData(
                                            domain: e.key + 1,
                                            measure: e.value),
                                      )
                                      .toList(),
                                ),
                              ],
                            );
                    },
                    errorView: (context, error) =>
                        ErrorView(errorText: error.toString()),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
    );
  }
}

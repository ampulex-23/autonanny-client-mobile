import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanny_components/base_views/admin_part/view_models/finance_management_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class FinanceManagementView extends StatefulWidget {
  const FinanceManagementView({super.key});

  @override
  State<FinanceManagementView> createState() => _FinanceManagementViewState();
}

class _FinanceManagementViewState extends State<FinanceManagementView> {
  late FinanceManagementVM vm;

  @override
  void initState() {
    super.initState();
    vm = FinanceManagementVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NannyTheme.lightPink,
      appBar: NannyAppBar(
        title: "Управление финансами",
        isTransparent: false,
        color: NannyTheme.secondary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 19, right: 17, left: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                DateType.values.length,
                (index) => GestureDetector(
                  onTap: () => vm.onDateTypeSelect(DateType.values[index]),
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
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text("Текущий баланс:"),
              const SizedBox(height: 10),
              RequestLoader(
                request: vm.getMoney,
                completeView: (context, data) => Text(
                    vm.formatCurrency(data!.balance),
                    style: Theme.of(context).textTheme.titleMedium),
                errorView: (context, error) =>
                    ErrorView(errorText: error.toString()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Image.asset(
                    "packages/nanny_components/assets/images/card.png"),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            vm.statsSwitch(switchToWithdraw: false),
                        style: vm.withdrawSelected
                            ? NannyButtonStyles.whiteButton
                            : null,
                        child: const Text("Комиссии"),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => vm.statsSwitch(switchToWithdraw: true),
                        style: vm.withdrawSelected
                            ? null
                            : NannyButtonStyles.whiteButton,
                        child: const Text("Транзакции"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.sizeOf(context).height * .5),
                child: NannyBottomSheet(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: RequestLoader(
                      request: vm.getMoney,
                      completeView: (context, data) =>
                          Builder(builder: (context) {
                        List<History> history = data!.history
                            .where(
                              (el) => el.title.toLowerCase().contains(
                                  vm.withdrawSelected
                                      ? "снятие"
                                      : "пополнение"),
                            )
                            .toList();
                        return history.isEmpty
                            ? Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.sizeOf(context).height *
                                        0.1),
                                child: const Center(
                                  child: Text(
                                      'Вы еще не совершили ни одной операции'),
                                ),
                              )
                            : ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: history
                                    .map(
                                      (e) => ListTile(
                                        leading: Text(e.title),
                                        trailing: Text("${e.amount} Р"),
                                      ),
                                    )
                                    .toList(),
                              );
                      }),
                      errorView: (context, error) =>
                          ErrorView(errorText: error.toString()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

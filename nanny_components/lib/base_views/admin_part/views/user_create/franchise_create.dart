import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/admin_part/view_models/user_create/franchise_create_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_components/widgets/custom_radio_list_tile.dart';
import 'package:nanny_core/api/api_models/static_data.dart';

class FranchiseCreateView extends StatefulWidget {
  const FranchiseCreateView({super.key});

  @override
  State<FranchiseCreateView> createState() => _FranchiseCreateViewState();
}

class _FranchiseCreateViewState extends State<FranchiseCreateView> {
  late FranchiseCreateVM vm;

  @override
  void initState() {
    super.initState();
    vm = FranchiseCreateVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NannyAppBar(
        title: "Франшиза",
        color: NannyTheme.secondary,
        isTransparent: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Выберите роль:",
              style: TextStyle(
                  fontSize: 18, height: 20 / 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => CustomRadioListTile(
                      isSelected: vm.items[index].checked,
                      title: vm.items[index].type.name,
                      onTap: () => vm.changeSelection(vm.items[index]),
                    ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: vm.items.length,
                shrinkWrap: true),
            const SizedBox(height: 24),
            const Text(
              "Сгенерируйте данные:",
              style: TextStyle(
                  fontSize: 18, height: 20 / 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            Form(
              key: vm.phoneState,
              child: NannyTextForm(
                isExpanded: true,
                labelText: "Номер телефона*",
                hintText: "+7 (777) 777-77-77",
                formatters: [vm.phoneMask],
                validator: (text) {
                  if (vm.phone.length < 11) {
                    return "Введите номер телефона!";
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: vm.passwordState,
              child: NannyTextForm(
                isExpanded: true,
                labelText: "Пароль*",
                hintText: "••••••••",
                controller: vm.passwordController,
                validator: vm.validatePassword,
                suffixIcon: GestureDetector(
                  onTap: () {
                    vm.generatePassword();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                        'packages/nanny_components/assets/images/sync.svg',
                        height: 24,
                        width: 24),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            citiesList(vm.selectedCities),
            const SizedBox(height: 24),
            const Text(
              "Сгенерированные данные отправятся на указанный номер телефона*",
              style: TextStyle(
                  fontSize: 12,
                  height: 14.4 / 12,
                  fontWeight: FontWeight.w600,
                  color: NannyTheme.darkGrey),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: vm.createUser,
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: const WidgetStatePropertyAll(
                    Size(double.infinity, 60),
                  ),
                ),
                child: const Text("Отправить данные"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget citiesList(List<StaticData> cities) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Город(а)*",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Divider(color: NannyTheme.onSecondary),
            ListView(
              shrinkWrap: true,
              children: cities
                  .map((e) => Card(
                        child: ListTile(
                          title: Text(e.title),
                          trailing: IconButton(
                            onPressed: () => vm.removeCity(e),
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ),
                      ) as Widget)
                  .toList()
                ..add(IconButton(
                    onPressed: vm.selectCity, icon: const Icon(Icons.add))),
            ),
          ],
        ),
      ),
    );
  }
}

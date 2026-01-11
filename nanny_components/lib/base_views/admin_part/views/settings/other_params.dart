import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/admin_part/view_models/settings/other_params_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/models/from_api/other_parametr.dart';
import 'package:nanny_core/nanny_core.dart';

class OtherParamsSettings extends StatefulWidget {
  const OtherParamsSettings({super.key});

  @override
  State<OtherParamsSettings> createState() => _OtherParamsSettingsState();
}

class _OtherParamsSettingsState extends State<OtherParamsSettings> {
  late OtherParamsVM vm;

  @override
  void initState() {
    super.initState();
    vm = OtherParamsVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: NannyTheme.secondary,
        appBar: const NannyAppBar(
            title: "Дополнительные услуги",
            color: NannyTheme.secondary,
            isTransparent: false),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              const EdgeInsets.only(top: 30, right: 16, left: 16, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Стоимость дополнительных услуг",
                style: TextStyle(
                    color: NannyTheme.onSecondary.withOpacity(.75),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 20 / 18),
              ),
              const SizedBox(height: 20),
              RequestListLoader(
                request: NannyStaticDataApi.getOtherParams(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                tileTemplate: (context, e) => Slidable(
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        padding: EdgeInsets.zero,
                        onPressed: (context) => vm.paramAction(
                          NannyAdminApi.deleteOtherParametr(
                            OtherParametr(id: e.id),
                          ),
                        ),
                        icon: Icons.delete,
                        label: "Удалить",
                        backgroundColor: Colors.red,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ListTile(
                        minLeadingWidth: 0,
                        minTileHeight: 0,
                        minVerticalPadding: 0,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          e.title ?? "Неизвестная услуга",
                          style: const TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 17.6 / 16),
                        ),
                        trailing: Text(
                          vm.formatCurrency(e.amount ?? 0),
                          style: const TextStyle(color: NannyTheme.primary),
                        ),
                        onTap: () => showParamsDialog(e),
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: NannyTheme.grey, height: 0),
                    ],
                  ),
                ),
                errorView: (context, error) =>
                    ErrorView(errorText: error.toString()),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: newParam,
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
                  child: const Text("Создать новую услугу"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showParamsDialog(OtherParametr param) async {
    final formKey = GlobalKey<FormState>(); // Создаем FormKey
    String amount = "";

    await NannyDialogs.showModalDialog(
      context: context,
      hasDefaultBtn: false,
      title: param.title,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: NannyTextForm(
            labelText: "Стоимость",
            onChanged: (text) => amount = text,
            keyType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Поле не должно быть пустым";
              }
              if (double.tryParse(value) == null) {
                return "Введите корректное число";
              }
              if (double.parse(value) <= 0) {
                return "Стоимость должна быть больше 0";
              }
              return null;
            },
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              vm.paramAction(
                NannyAdminApi.updateOtherParametr(
                  OtherParametr(
                    id: param.id,
                    title: param.title,
                    amount: double.parse(amount),
                  ),
                ),
                previewDialogContexts: [context],
              );
            }
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            minimumSize: WidgetStatePropertyAll(
              Size(MediaQuery.of(context).size.width - 80, 60),
            ),
          ),
          child: const Text("Ок"),
        ),
      ],
    );
  }

  void newParam() async {
    final formKey = GlobalKey<FormState>(); // Уникальный FormKey
    String title = "";
    String amount = "";

    await NannyDialogs.showModalDialog(
      context: context,
      title: 'Создание доп.услуги',
      hasDefaultBtn: false,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              NannyTextForm(
                labelText: "Название",
                onChanged: (text) => title = text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Поле не должно быть пустым";
                  }
                  if (value.length < 3) {
                    return "Название должно быть длиннее 3 символов";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              NannyTextForm(
                labelText: "Стоимость",
                onChanged: (text) => amount = text,
                keyType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Поле не должно быть пустым";
                  }
                  if (double.tryParse(value) == null) {
                    return "Введите корректное число";
                  }
                  if (double.parse(value) <= 0) {
                    return "Стоимость должна быть больше 0";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              vm.paramAction(
                NannyAdminApi.createOtherParametr(
                  OtherParametr(
                    title: title,
                    amount: double.parse(amount),
                  ),
                ),
                previewDialogContexts: [context],
              );
              Navigator.pop(context);
            }
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            minimumSize: WidgetStatePropertyAll(
              Size(MediaQuery.of(context).size.width - 80, 60),
            ),
          ),
          child: const Text("Создать"),
        ),
      ],
    );
  }
}

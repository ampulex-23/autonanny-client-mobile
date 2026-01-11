import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/admin_part/view_models/settings/security_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_components/widgets/settings_tile.dart';

class SecuritySettingsView extends StatefulWidget {
  const SecuritySettingsView({super.key});

  @override
  State<SecuritySettingsView> createState() => _SecuritySettingsViewState();
}

class _SecuritySettingsViewState extends State<SecuritySettingsView> {
  late SecurityVM vm;

  @override
  void initState() {
    super.initState();
    vm = SecurityVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const NannyAppBar(
            title: "Безопасность",
            color: NannyTheme.secondary,
            isTransparent: false),
        body: FutureLoader(
          future: vm.initFuture,
          completeView: (context, data) {
            if (!data) {
              return const ErrorView(
                  errorText:
                      "Не удалось загрузить данные настроек.\nПовторите попытку позже...");
            }

            return ListView(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
              children: [
                SettingsTile(
                  title: "Вход через Face/Touch Id",
                  trailing: Switch(
                    value: vm.useBiometrics,
                    onChanged: vm.switchBiometrics,
                    activeColor: NannyTheme.primary,
                  ),
                ),
              ],
            );
          },
          errorView: (context, error) => ErrorView(errorText: error.toString()),
        ),
      ),
    );
  }
}

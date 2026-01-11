import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/admin_part/views/settings/other_params.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_components/widgets/settings_tile.dart';

class SystemSettingsView extends StatefulWidget {
  const SystemSettingsView({super.key});

  @override
  State<SystemSettingsView> createState() => _SystemSettingsViewState();
}

class _SystemSettingsViewState extends State<SystemSettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NannyTheme.secondary,
      appBar: const NannyAppBar(
          title: "Настройка системы",
          color: NannyTheme.secondary,
          isTransparent: false),
      body: ListView(
        padding:
            const EdgeInsets.only(top: 48, bottom: 48, left: 16, right: 16),
        children: [
          //SettingsTile(
          //  title: "Безопасность",
          //  trailing: SvgPicture.asset(
          //      'packages/nanny_components/assets/images/arrow.svg'),
          //  //path: const SecuritySettingsView(),
          //),
          //const Padding(
          //  padding: EdgeInsets.symmetric(vertical: 20),
          //  child: Divider(color: NannyTheme.grey),
          //),
          //SettingsTile(
          //  title: "Обновления",
          //  trailing: SvgPicture.asset(
          //      'packages/nanny_components/assets/images/arrow.svg'),
          //  //path: const UpdatesSettingsView(),
          //),
          //const Padding(
          //  padding: EdgeInsets.symmetric(vertical: 20),
          //  child: Divider(color: NannyTheme.grey),
          //),
          //SettingsTile(
          //  title: "Оплата",
          //  trailing: SvgPicture.asset(
          //      'packages/nanny_components/assets/images/arrow.svg'),
          //  //path: const PaymentsSettingsView(),
          //),
          //const Padding(
          //  padding: EdgeInsets.symmetric(vertical: 20),
          //  child: Divider(color: NannyTheme.grey),
          //),
          //SettingsTile(
          //  title: "Коэффициенты формулы",
          //  trailing: SvgPicture.asset(
          //      'packages/nanny_components/assets/images/arrow.svg'),
          //  //path: const FormulaSettingView(),
          //),
          //const Padding(
          //  padding: EdgeInsets.symmetric(vertical: 20),
          //  child: Divider(color: NannyTheme.grey),
          //),
          SettingsTile(
            title: "Дополнительные услуги",
            trailing: SvgPicture.asset(
                'packages/nanny_components/assets/images/arrow.svg'),
            path: const OtherParamsSettings(),
          ),
        ],
      ),
    );
  }
}

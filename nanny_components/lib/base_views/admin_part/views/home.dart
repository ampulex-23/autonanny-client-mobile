import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanny_components/base_views/admin_part/view_models/home_vm.dart';
import 'package:nanny_components/base_views/admin_part/views/finance_management.dart';
import 'package:nanny_components/base_views/admin_part/views/order_management.dart';
import 'package:nanny_components/base_views/admin_part/views/referral_program.dart';
import 'package:nanny_components/base_views/admin_part/views/reports_management.dart';
import 'package:nanny_components/base_views/admin_part/views/system_settings.dart';
import 'package:nanny_components/base_views/admin_part/views/user_create/user_create.dart';
import 'package:nanny_components/base_views/admin_part/views/user_management.dart';
import 'package:nanny_components/nanny_components.dart';

class AdminHomeView extends StatefulWidget {
  final Widget regView;

  const AdminHomeView({
    super.key,
    required this.regView,
  });

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  late AdminHomeVM vm;

  @override
  void initState() {
    super.initState();
    vm = AdminHomeVM(
      context: context,
      update: setState,
      regView: widget.regView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NannyAppBar(
        title: "Панель управления",
        hasBackButton: false,
        color: Color(0xFFfafafa),
        leading: IconButton(
            onPressed: vm.navigateToProfile,
            icon: const Icon(Icons.account_circle),
            iconSize: 25),
      ),
      body: Center(
        child: GridView(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          children: [
            AdminPanelButton(
                onPressed: () => vm.navigateToView(const SystemSettingsView()),
                text: "Настройка параметров системы",
                imgPath: "rocket.png",
                style: NannyButtonStyles.defaultButtonStyle),
            AdminPanelButton(
              onPressed: () => vm.navigateToView(const UserManagementView()),
              text: "Управление пользователями",
              imgPath: "connection.png",
            ),
            AdminPanelButton(
                onPressed: () => vm.navigateToView(const OrderManagement()),
                text: "Управление заказами",
                imgPath: "yo.png"),
            AdminPanelButton(
                onPressed: () =>
                    vm.navigateToView(const FinanceManagementView()),
                text: "Управление финансами",
                imgPath: "money.png"),
            AdminPanelButton(
                onPressed: () =>
                    vm.navigateToView(const ReportsManagementView()),
                text: "Управление отчетами",
                imgPath: "files.png"),
            AdminPanelButton(
              onPressed: () => vm.navigateToView(const ReferralProgramView()),
              text: "Реферальная программа с партнерами",
              imgPath: "avatar.png",
              bottomPadding: -20,
            ),
            AdminPanelButton(
                onPressed: () => vm.navigateToView(const UserCreateView()),
                text: "Создание пользователя",
                imgPath: "edit.png"),
          ],
        ),
      ),
    );
  }
}

class AdminPanelButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double imgSize;
  final double rightPadding;
  final double bottomPadding;
  final VoidCallback onPressed;
  final String text;
  final String imgPath;
  final ButtonStyle style;

  const AdminPanelButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.imgPath,
    this.width,
    this.height,
    this.style = NannyButtonStyles.whiteButton,
    this.imgSize = 100,
    this.rightPadding = 0,
    this.bottomPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(text),
              ),
              Positioned(
                  right: rightPadding,
                  bottom: bottomPadding,
                  child: Image.asset(
                      'packages/nanny_components/assets/images/$imgPath',
                      height: imgSize)),
            ],
          )),
    );
  }
}

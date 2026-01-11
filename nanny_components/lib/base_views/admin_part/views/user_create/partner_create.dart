import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/admin_part/view_models/user_create/partner_create_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class PartnerCreateView extends StatefulWidget {
  const PartnerCreateView({super.key});

  @override
  State<PartnerCreateView> createState() => _PartnerCreateViewState();
}

class _PartnerCreateViewState extends State<PartnerCreateView> {
  late PartnerCreateVM vm;

  @override
  void initState() {
    super.initState();
    vm = PartnerCreateVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    print(DioRequest.authToken);
    return Scaffold(
      backgroundColor: NannyTheme.secondary,
      appBar: const NannyAppBar(
        title: "Партнер",
        color: NannyTheme.secondary,
        isTransparent: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Сгенерируйте данные",
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
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            Form(
              key: vm.refState,
              child: NannyTextForm(
                isExpanded: true,
                controller: vm.refController,
                labelText: "Реферальная ссылка*",
                validator: vm.validateReferralLink,
                suffixIcon: GestureDetector(
                  onTap: () {
                    vm.generateReferralLink();
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
            const SizedBox(height: 26),
            const Text(
              "Сгенерированные данные отправятся на указанный номер телефона*",
              style: TextStyle(
                  fontSize: 12,
                  height: 14.4 / 12,
                  fontWeight: FontWeight.w600,
                  color: NannyTheme.darkGrey),
            ),
            const Spacer(),
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
}

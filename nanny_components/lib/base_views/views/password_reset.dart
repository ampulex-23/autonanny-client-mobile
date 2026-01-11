import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/view_models/password_reset_vm.dart';
import 'package:nanny_components/nanny_components.dart';

class PasswordResetView extends StatefulWidget {
  const PasswordResetView({super.key});

  @override
  State<PasswordResetView> createState() => _PasswordResetViewState();
}

class _PasswordResetViewState extends State<PasswordResetView> {
  late PasswordResetVm vm;

  @override
  void initState() {
    super.initState();
    vm = PasswordResetVm(context: context, update: setState);
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const NannyAppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Восстановление пароля", style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 10),
                Text("Задайте новый пароль для аккаунта", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 10),
                Form(
                  key: vm.passState,
                  child: NannyPasswordForm(
                    labelText: "Новый пароль*",
                    validator: (text) {
                      if(vm.password.length < 8) return "Пароль не менее 8 символов!";
                      return null;
                    },
                    onChanged: (text) => vm.password = text,
                  ),
                ),
                const SizedBox(height: 10),
                Form(
                  key: vm.passConfirmState,
                  child: NannyPasswordForm(
                    labelText: "Подтвердите новый пароль*",
                    validator: (text) {
                      if(vm.password != vm.passwordConfirm) return "Пароли должны совпадать!";
                      return null;
                    },
                    onChanged: (text) => vm.passwordConfirm = text,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: vm.tryResetPassword, 
                  child: const Text("Обновить пароль")
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
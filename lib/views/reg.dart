import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanny_client/view_models/reg_vm.dart';
import 'package:nanny_components/nanny_components.dart';

class RegView extends StatefulWidget {
  const RegView({super.key});

  @override
  State<RegView> createState() => _RegViewState();
}

class _RegViewState extends State<RegView> {
  late RegVM vm;

  @override
  void initState() {
    super.initState();
    vm = RegVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const NannyAppBar(),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
                child: Column(children: [
              Text("Регистрация аккаунта",
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 50),
              NannyTextForm(
                  formatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[^\d\W_]+$'))
                  ],
                  labelText: "Имя*",
                  //errorText: vm.errorTextName,
                  hintText: "Введите имя",
                  onChanged: (text) => vm.firstName = text),
              const SizedBox(height: 10),
              NannyTextForm(
                  formatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[^\d\W_]+$'))
                  ],
                  labelText: "Фамилия*",
                  //errorText: vm.errorTextSurname,
                  hintText: "Введите фамилию",
                  onChanged: (text) => vm.lastName = text),
              const SizedBox(height: 10),
              Form(
                  key: vm.passwordState,
                  child: NannyPasswordForm(
                      labelText: "Пароль*",
                      //errorText: vm.errorText,
                      hintText: "Введите пароль",
                      validator: (text) {
                        if (vm.password.length < 8) {
                          return "Пароль не меньше 8 символов!";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        vm.password = text;
                        vm.errorText = null;
                      })),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: vm.tryReg,
                  child: const Text("Зарегистрироваться")),
            ]))));
  }
}

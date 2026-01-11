import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanny_components/base_views/view_models/login_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class LoginView extends StatefulWidget {
  final String imgPath;
  final List<LoginPath> paths;

  const LoginView({
    super.key,
    required this.imgPath,
    required this.paths,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginVM vm;

  Widget testPath(String text) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    vm = LoginVM(
      context: context,
      update: setState,
      availableRoleLogin: widget.paths,
      paths: widget.paths,
    );
  }

  @override
  void dispose() {
    // Можно сбросить стиль при выходе с экрана
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Color(0xFFfafafa),
          statusBarIconBrightness: Brightness.dark),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Color(0xFFfafafa),
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      backgroundColor: NannyTheme.background,
      appBar: const NannyAppBar(),
      extendBodyBehindAppBar: true,
      body: AdaptBuilder(builder: (context, size) {
        return Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset(widget.imgPath, height: size.height * .4)),
            Align(
              alignment: Alignment.bottomCenter,
              child: NannyBottomSheet(
                height: size.height * .6,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Text("Вход в аккаунт",
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 30),
                      Form(
                        key: vm.phoneState,
                        child: NannyTextForm(
                          isExpanded: true,
                          labelText: "Телефон",
                          hintText: "+7 (777) 777 77-77",
                          formatters: [vm.phoneMask],
                          keyType: TextInputType.number,
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
                        child: NannyPasswordForm(
                          isExpanded: true,
                          labelText: "Пароль",
                          hintText: "••••••••",
                          validator: (text) {
                            if (vm.password.length < 8) {
                              return "Пароль не менее 8 символов!";
                            }
                            return null;
                          },
                          onChanged: (v) => vm.password = v,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: vm.isLoading ? null : vm.tryLogin,
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
                        child: const Text("Войти"),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                          onPressed: vm.toPasswordReset,
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
                          child: const Text("Забыли пароль?")),
                      const SizedBox(height: 20),
                      //if (vm.canOauth)
                      //  Text("Или зарегистрируйтесь через соц сети",
                      //      style: Theme.of(context).textTheme.bodyMedium),
                      //if (vm.canOauth) const SizedBox(height: 10),
                      //if (vm.canOauth)
                      //  Padding(
                      //      padding:
                      //          const EdgeInsets.symmetric(horizontal: 100),
                      //      child: Row(
                      //        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //        children: [
                      //          IconButton(
                      //              onPressed: vm.yandexAuth,
                      //              icon: Image.asset(
                      //                'packages/nanny_components/assets/images/yandex_auth.png',
                      //                width: 50,
                      //              )),
                      //          IconButton(
                      //              onPressed: vm.vkAuth,
                      //              icon: Image.asset(
                      //                'packages/nanny_components/assets/images/vk_auth.png',
                      //                width: 50,
                      //              )),
                      //          IconButton(
                      //              onPressed: vm.telegramAuth,
                      //              icon: Image.asset(
                      //                'packages/nanny_components/assets/images/telegram_auth.png',
                      //                width: 50,
                      //              )),
                      //        ],
                      //      )),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

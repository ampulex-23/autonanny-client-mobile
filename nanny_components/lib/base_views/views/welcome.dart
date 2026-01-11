import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanny_components/base_views/view_models/welcome_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class WelcomeView extends StatefulWidget {
  final Widget regView;
  final List<LoginPath> loginPaths;

  const WelcomeView({
    super.key,
    required this.regView,
    required this.loginPaths,
  });

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  late final WelcomeVM vm;

  @override
  void initState() {
    super.initState();
    vm = WelcomeVM(
        context: context,
        update: setState,
        regScreen: widget.regView,
        loginPaths: widget.loginPaths);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NannyAppBar(
        hasBackButton: false,
        color: Color(0xFAFAFAFA),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("packages/nanny_components/assets/images/icon.png",
                height: 150),
            const SizedBox(height: 10),
            Text("Няня Go",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: NannyTheme.primary)),
            const SizedBox(height: 10),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: vm.navigateToLogin,
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
            ElevatedButton(
              style: NannyButtonStyles.whiteButton.copyWith(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                minimumSize: const WidgetStatePropertyAll(
                  Size(double.infinity, 60),
                ),
              ),
              onPressed: vm.navigateToReg,
              child: const Text("Зарегистрироваться"),
            ),
          ],
        ),
      )),
    );
  }
}

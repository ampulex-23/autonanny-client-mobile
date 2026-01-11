import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/view_models/pin_login_vm.dart';
import 'package:nanny_components/nanny_components.dart';

class PinLoginView extends StatefulWidget {
  final Widget nextView;
  final Widget logoutView;
  
  const PinLoginView({
    super.key,
    required this.nextView,
    required this.logoutView
  });

  @override
  State<PinLoginView> createState() => _PinLoginViewState();
}

class _PinLoginViewState extends State<PinLoginView> {
  late PinLoginVM vm;

  @override
  void initState() {
    super.initState();
    vm = PinLoginVM(
      context: context, 
      update: setState, 
      nextView: widget.nextView, 
      logoutView: widget.logoutView,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: NannyTheme.background,
        appBar: NannyAppBar(
          hasBackButton: false,
          actions: [
            IconButton(
              onPressed: vm.logout, 
              icon: const Icon(Icons.exit_to_app_rounded),
              splashRadius: 30,
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: FutureLoader(
            future: vm.isBioAuthAvailable,
            completeView: (context, data) => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 60, right: 30, bottom: 30),
                    child: Text(
                      "Введите код авторизации", 
                      textAlign: TextAlign.center, 
                      style: Theme.of(context).textTheme.headlineSmall
                    ),
                  ),
                ),
                Expanded(
                  child: FourDigitKeyboard(
                    bottomChild: data ? TextButton(
                      onPressed: vm.useBioAuth,
                      child: const Text("Использовать биометрию")
                    ) : null,
                    onCodeChanged: (code) {
                      vm.code = code;
                      if(code.length > 3) vm.checkPinCode();
                    },
                  ),
                ),
              ],
            ), 
            errorView: (context, error) => ErrorView(errorText: error.toString()),
          ),
        ),
      ),
    );
  }
}
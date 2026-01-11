import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/view_models/first_pin_set_vm.dart';
import 'package:nanny_components/widgets/four_digit_keyboard.dart';

class FirstPinSet extends StatefulWidget {
  final Widget nextView;
  
  const FirstPinSet({
    super.key,
    required this.nextView,
  });

  @override
  State<FirstPinSet> createState() => _FirstPinSetState();
}

class _FirstPinSetState extends State<FirstPinSet> {
  late FirstPinSetVM vm;

  @override
  void initState() {
    super.initState();
    vm = FirstPinSetVM(context: context, update: setState, nextView: widget.nextView);
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Text(
                    "Задайте код авторизации в приложении", 
                    textAlign: TextAlign.center, 
                    style: Theme.of(context).textTheme.headlineSmall
                  ),
                ),
              ),
              Expanded(
                child: FourDigitKeyboard(
                  onCodeChanged: (code) {
                    vm.code = code;
                    if(code.length > 3) vm.setPinCode();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
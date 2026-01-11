import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/view_models/phone_confirm_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/models/login_path.dart';

class PhoneConfirmView extends StatefulWidget {
  final Widget nextScreen;
  final String title;
  final String text;
  final bool isReg;
  final List<LoginPath> loginPaths;

  const PhoneConfirmView({
    super.key,
    required this.nextScreen,
    required this.title,
    required this.text,
    required this.isReg,
    required this.loginPaths,
  });

  @override
  State<PhoneConfirmView> createState() => _PhoneConfirmViewState();
}

late PhoneConfirmVM _vm;

class _PhoneConfirmViewState extends State<PhoneConfirmView> {
  @override
  void initState() {
    super.initState();
    _vm = PhoneConfirmVM(
      baseContext: context,
      context: context,
      update: setState,
      nextScreen: widget.nextScreen,
      title: widget.title,
      text: widget.text,
      isReg: widget.isReg,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: NannyTheme.lightPink,
        appBar: NannyAppBar(
          color: NannyTheme.lightPink,
          actions: [
            if (_vm.currentView is PhoneEnterView)
              CupertinoButton(
                child: Text(
                  'Войти',
                  style: NannyTextStyles.defaultTextStyle.copyWith(
                    color: const Color(0xFF212121).withOpacity(.2),
                  ),
                ),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginView(
                        imgPath:
                            "packages/nanny_components/assets/images/Saly-10.png",
                        paths: widget.loginPaths),
                  ),
                ),
              )
          ],
        ),
        extendBodyBehindAppBar: _vm.extendBehindAppBar,
        resizeToAvoidBottomInset: false,
        body: _vm.currentView);
  }
}

class PhoneEnterView extends StatelessWidget {
  final String title;
  final String text;

  const PhoneEnterView({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _vm.phoneState,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: NannyTheme.onSecondary,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Nunito'),
              ),
              const SizedBox(height: 20),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Nunito'),
              ),
              const SizedBox(height: 27),
              NannyTextForm(
                isExpanded: true,
                labelText: "Номер телефона*",
                hintText: "+7 (777) 777-77-77",
                keyType: TextInputType.number,
                formatters: [_vm.phoneMask],
                validator: (text) {
                  // Проверяем, что пользователь ввел данные
                  if (text == null || text.isEmpty) {
                    return "Введите номер телефона!";
                  }

                  // Проверяем длину номера (без маски)
                  if (_vm.phoneMask.getUnmaskedText().length < 11) {
                    return "Введите полный номер телефона!";
                  }

                  return null; // Все ок, ошибок нет
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _vm.toPhoneConfirmation,
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
                child: const Text("Отправить код"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneEnterConfirmView extends StatefulWidget {
  const PhoneEnterConfirmView({super.key});

  @override
  State<PhoneEnterConfirmView> createState() => _PhoneEnterConfirmViewState();
}

class _PhoneEnterConfirmViewState extends State<PhoneEnterConfirmView> {
  @override
  void initState() {
    super.initState();
    _vm.update = setState;
    _vm.initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 150, right: 20, bottom: 40),
            child: Text(
              "Мы отправили вам\nСМС код",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Fregat'),
            ),
          ),
          Expanded(
            child: FourDigitKeyboard(
              topChild: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    const TextSpan(
                      text: "На номер: ",
                      style: TextStyle(
                          color: Color(0xFF6D6D6D),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Nunito'),
                    ),
                    TextSpan(
                        text: _vm.phoneMask.getMaskedText(),
                        style: const TextStyle(color: NannyTheme.primary)),
                  ],
                ),
              ),
              bottomChild: _vm.timerEnded
                  ? TextButton(
                      onPressed: _vm.resendSms,
                      child: const Text("Отправить СМС заново"))
                  : SmsTimer(secFrom: _vm.timeLeft, onEnd: _vm.onTimerEnd),
              onCodeChanged: (code) {
                _vm.code = code;
                if (code.length > 3) _vm.checkPhone();
              },
            ),
          ),
        ],
      ),
    );
  }
}

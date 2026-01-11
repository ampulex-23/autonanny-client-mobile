import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nanny_components/base_views/views/phone_confirm.dart';
import 'package:nanny_components/dialogs/loading.dart';
import 'package:nanny_components/text_masks.dart';
import 'package:nanny_components/view_model_base.dart';
import 'package:nanny_core/api/api_models/check_code_request.dart';
import 'package:nanny_core/nanny_core.dart';

class PhoneConfirmVM extends ViewModelBase {
  PhoneConfirmVM({
    required super.context,
    required super.update,
    required this.baseContext,
    required this.nextScreen,
    required this.title,
    required this.text,
    required this.isReg,
  }) {
    currentView = PhoneEnterView(title: title, text: text);
  }

  final BuildContext baseContext;
  final String title;
  final String text;
  final bool isReg;

  final Widget nextScreen;

  late Widget currentView;
  bool extendBehindAppBar = false;

  int timeLeft = 0;
  bool timerEnded = false;

  MaskTextInputFormatter phoneMask = TextMasks.phoneMask();
  String get phone => "7${phoneMask.getUnmaskedText()}";

  String code = "";

  GlobalKey<FormState> phoneState = GlobalKey();

  void initTimer() {
    timerEnded = false;

    // Если отправка SMS еще не была инициирована, инициируем ее
    if (NannyGlobals.lastSmsSend == null) {
      NannyGlobals.lastSmsSend = DateTime.now();
      sendSms();
    }

    // Рассчитываем оставшееся время до конца таймера
    timeLeft =
        60 - (DateTime.now().difference(NannyGlobals.lastSmsSend!).inSeconds);

    if (timeLeft <= 0) {
      // Если время истекло, отправляем SMS снова
      NannyGlobals.lastSmsSend = DateTime.now();
      timeLeft =
          60 - (DateTime.now().difference(NannyGlobals.lastSmsSend!).inSeconds);
      sendSms();
    }
  }

  void sendSms() {
    Logger().d("Sent SMS");
    late Future<ApiResponse> request;
    if (isReg) {
      request = NannyAuthApi.getRegCode(phone);
    } else {
      request = NannyAuthApi.getResetCode(phone);
    }

    DioRequest.handleRequest(context, request);
  }

  void onTimerEnd() => update(() {
        timerEnded = true;
        Logger().d("SMS timer ended");
      });

  void resendSms() {
    Logger().d("Resending SMS...");

    // Обнуляем последнее время отправки и повторно инициализируем таймер
    NannyGlobals.lastSmsSend = null;
    initTimer();

    update(() {
      timerEnded = false;
    });
  }

  void checkPhone() async {
    LoadScreen.showLoad(context, true);

    bool success = await DioRequest.handleRequest(
      context,
      isReg
          ? NannyAuthApi.checkRegCode(
              CheckCodeRequest(phone: phone, code: code),
            )
          : NannyAuthApi.checkResetCode(
              CheckCodeRequest(phone: phone, code: code),
            ),
    );

    if (!success) return;
    if (!context.mounted) return;
    NannyGlobals.phone = phone;
    LoadScreen.showLoad(context, false);
    Navigator.pushReplacement(
        baseContext, MaterialPageRoute(builder: (context) => nextScreen));
  }

  void toPhoneConfirmation() {
    if (!phoneState.currentState!.validate() || phone.length < 11) {
      update(() {});
      return;
    }

    // Сбрасываем состояние таймера и отправляем новый код для нового номера
    NannyGlobals.lastSmsSend = null;
    initTimer();

    update(() {
      currentView = const PhoneEnterConfirmView();
      extendBehindAppBar = true;
    });
  }
}

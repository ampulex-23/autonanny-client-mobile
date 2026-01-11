import 'package:flutter/material.dart';
import 'package:nanny_components/dialogs/loading.dart';
import 'package:nanny_components/view_model_base.dart';
import 'package:nanny_core/nanny_core.dart';

class FirstPinSetVM extends ViewModelBase {
  FirstPinSetVM({
    required super.context,
    required super.update,
    required this.nextView,
  });

  final Widget nextView;

  String code = "";

  void setPinCode() async {
    if (code.length < 4) return; // На всякий случай...

    LoadScreen.showLoad(context, true);

    bool success = await DioRequest.handleRequest(
      context,
      NannyAuthApi.setPinCode(code),
    );

    if (!success) return;

    var data = await NannyStorage.getLoginData();
    await NannyStorage.updateLoginData(LoginStorageData(
      login: data!.login,
      password: data.password,
      // haveSetPincode: true,
    ));

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => nextView),
      (route) => false,
    );
  }
}

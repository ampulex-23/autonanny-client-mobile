import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';
// ignore: depend_on_referenced_packages
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class NannyLocalAuth {
  static late final LocalAuthentication _localAuth;
  static void init() => _localAuth = LocalAuthentication();

  static Future<bool> canUseBiometrics() async => (await _localAuth.canCheckBiometrics && await _localAuth.isDeviceSupported());
  static Future<bool> isBiometricsEnabled() async {
    var auth = NannyStaticDataApi.getBiometricSettings();

    bool success = await DioRequest.handleRequest(
      NannyGlobals.currentContext, 
      auth,
    );

    if(!success) return false;

    return (await auth).response!;
  }
  static Future<bool> auth(BuildContext context, String promt) async {
    try {
      return _localAuth.authenticate(
        localizedReason: promt,
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
        authMessages: const [
          AndroidAuthMessages(
            cancelButton: "Отмена",
            signInTitle: "Аутентификация",
            biometricHint: "",
          )
        ]
      );
    } on PlatformException {
      NannyDialogs.showMessageBox(context, "Ошибка!", "Было сделано слишком много неудачных попыток");
      return false;
    }
  }
}
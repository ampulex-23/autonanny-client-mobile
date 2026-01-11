import 'package:flutter/material.dart';
import 'package:nanny_components/dialogs/loading.dart';
import 'package:nanny_components/view_model_base.dart';
import 'package:nanny_core/nanny_core.dart';
import 'package:nanny_core/nanny_local_auth.dart';

class PinLoginVM extends ViewModelBase {
  PinLoginVM({
    required super.context, 
    required super.update,
    required this.nextView,
    required this.logoutView,
  }) {
    isBioAuthAvailable = canBioAuth();
    bioLoginInitial();
  }

  final Widget nextView;
  final Widget logoutView;

  late final Future<bool> isBioAuthAvailable;

  String code = "";

  void bioLoginInitial() async {
    if(!await isBioAuthAvailable) return;

    useBioAuth();
  }

  void checkPinCode() async {
    if(code.length < 4) return;

    LoadScreen.showLoad(context, true);

    bool success = await DioRequest.handleRequest(
      context, 
      NannyAuthApi.checkPinCode(code),
    );

    if(!success) return;
    if(!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context) => nextView),
      (route) => false,
    );
  }

  Future<bool> canBioAuth() async {
    var data = await NannyStorage.getSettingsData();
    if(data == null) return false;

    return await NannyLocalAuth.canUseBiometrics() && await NannyLocalAuth.isBiometricsEnabled() && data.useBiometrics;
  }

  void useBioAuth() async {
    bool auth = await NannyLocalAuth.auth(context, "Используйте биометрию, чтобы авторизоваться");

    if(!auth) return;
    if(!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context) => nextView),
      (route) => false,
    );
  }
  
  void logout() async {
    var success = await DioRequest.handleRequest(
      context, 
      NannyUser.logout()
    );

    if(!success) return;
    if(!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context) => logoutView), 
      (route) => false
    );
  }
}
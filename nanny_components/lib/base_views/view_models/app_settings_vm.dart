import 'package:nanny_components/view_model_base.dart';
import 'package:nanny_core/nanny_core.dart';
import 'package:nanny_core/nanny_local_auth.dart';

class AppSettingsVM extends ViewModelBase {
  AppSettingsVM({
    required super.context, 
    required super.update,
  }) {
    init = initSettings();
  }

  late bool _useTouchId;
  bool get useTouchId => _useTouchId;

  late bool _bioAuthEnabled;
  bool get bioAuthEnabled => _bioAuthEnabled;
  
  late bool _canUseBio;
  bool get canUseBio => _canUseBio;

  late final Future<bool> init;

  Future<bool> initSettings() async {
    _bioAuthEnabled = await NannyLocalAuth.isBiometricsEnabled();
    _canUseBio = await NannyLocalAuth.canUseBiometrics();
    
    var data = await NannyStorage.getSettingsData();
    if(data == null) {
      _useTouchId = false;
      return false;
    }

    _useTouchId = data.useBiometrics && _canUseBio && _bioAuthEnabled;
    return true;
  }

  void signInWithTouchId(bool? value) async {
    await NannyStorage.updateSettingsData(
      SettingsStorageData(
        useBiometrics: value!,
      )
    );

    update(() => _useTouchId = value);
  }
}

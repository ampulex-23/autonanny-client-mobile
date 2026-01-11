import 'package:nanny_components/dialogs/loading.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class SecurityVM extends ViewModelBase {
  SecurityVM({
    required super.context, 
    required super.update,
  }) {
    initFuture = init();
  }

  late Future<bool> initFuture;
  void refresh() => update( () {initFuture = init();} );

  Future<bool> init() async {
    var bios = await NannyStaticDataApi.getBiometricSettings();
    if(!bios.success) return false;

    useBiometrics = bios.response!;

    return true;
  }

  late bool useBiometrics;
  void switchBiometrics(bool? v) async {
    LoadScreen.showLoad(context, true);

    bool success = await DioRequest.handleRequest(
      context, 
      NannyAdminApi.changeBiometrySettings(),
    );

    if(!success) return;
    if(!context.mounted) return;

    LoadScreen.showLoad(context, false);
    refresh();
  }
}

import 'package:app_links/app_links.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class AppLinksHandler {
  static late AppLinks links;
  static void initAppLinkHandler() {
    links = AppLinks();
    links.uriLinkStream.listen((uri) async {
      var params = uri.queryParameters;

      Logger().i("Got app link:\n${uri.toString()}");
      // NannyDialogs.showMessageBox(NannyGlobals.currentContext, "CurrentUrl", uri.toString());
      if(params.containsKey("ref")) {
        bool success = await NannyUser.oauthLogin(params["ref"]!, NannyGlobals.currentContext);
        if(!success) {
          NannyDialogs.showMessageBox(
            // ignore: use_build_context_synchronously
            NannyGlobals.currentContext, "Ошибка!", "У вас нет аккаунта, привязанного к этому приложению!"
          );
        }
        return;
      }
    });
  }
}

import 'dart:io';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class HomeVM extends ViewModelBase {
  HomeVM({
    required super.context, 
    required super.update,
  }) {
    initialSetup();
  }

  int currentIndex = 1;
  void indexChanged(int index) => update(() => currentIndex = index);
  void initialSetup() async {
    await NannyGlobals.initChatSocket();
    
    // Firebase только для мобильных платформ
    if (Platform.isAndroid || Platform.isIOS) {
      FirebaseMessagingHandler.checkInitialMessage();
    }
  }
}
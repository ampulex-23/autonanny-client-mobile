import 'package:flutter/material.dart';
import 'package:nanny_core/nanny_core.dart';

class NannyLifecycleHandler extends WidgetsBindingObserver {

  final Future<void> Function()? resumeCallBack;
  final Future<void> Function()? detachedCallBack;
  final Future<void> Function()? hiddenCallBack;
  final Future<void> Function()? inactiveCallBack;
  final Future<void> Function()? pausedCallBack;

  NannyLifecycleHandler({
    this.resumeCallBack, 
    this.detachedCallBack, 
    this.hiddenCallBack, 
    this.inactiveCallBack, 
    this.pausedCallBack,
  });

  Logger log = Logger();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    
    switch (state) {
      case AppLifecycleState.hidden:
        log.i("LifeCycle state: Hidden");
        hiddenCallBack?.call();
      break;

      case AppLifecycleState.inactive:
        log.i("LifeCycle state: Inactive");
        inactiveCallBack?.call();
      break;

      case AppLifecycleState.paused:
        log.i("LifeCycle state: Paused");
        pausedCallBack?.call();
      break;

      case AppLifecycleState.detached:
        log.i("LifeCycle state: Detached");
        detachedCallBack?.call();
      break;

      case AppLifecycleState.resumed:
        log.i("LifeCycle state: Resumed");
        resumeCallBack?.call();
      break;
    }
  }
}

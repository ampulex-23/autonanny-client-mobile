import 'package:flutter/material.dart';

abstract class ViewModelBase {
  final BuildContext context;
  void Function(VoidCallback fun) update;

  ViewModelBase({required this.context, required this.update}) {
    _loadRequest = loadPage();
  }

  Future<void> navigateToView(Widget view) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => view),
      );

  Future slideNavigateToView(Widget view,
          {Offset beginOffset = const Offset(0, 1)}) async =>
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => view,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const Offset end = Offset(0, 0);
            final Tween<Offset> tween = Tween(begin: beginOffset, end: end);
            final CurveTween curve = CurveTween(curve: Curves.easeInOut);

            return SlideTransition(
              position: animation.drive(tween.chain(curve)),
              child: child,
            );
          },
        ),
      );

  void popView() => Navigator.pop(context);

  Future<bool> _loadRequest = Future(() => true);
  Future<bool> get loadRequest => _loadRequest;

  /// `true` - если все данные загрузились, иначе `false`
  Future<bool> loadPage() async => true;
  Future reloadPage() async {
    _loadRequest = loadPage();
    update(() {});
  }
}

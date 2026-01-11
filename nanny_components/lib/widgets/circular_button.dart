import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_svg/flutter_svg.dart';
import 'package:nanny_components/nanny_components.dart';

class CircularButton extends StatelessWidget {
  final Function() callback;
  final IconData? icon;
  final String label;
  final Widget? child;
  final double? padding;
  final bool withShadows;
  final String? asset;
  final bool needPadding;
  final bool sized;

  const CircularButton(
      {required this.callback,
      this.icon,
      required this.label,
      this.child,
      this.asset,
      this.needPadding = true,
      this.sized = true,
      this.withShadows = true,
      this.padding,
      super.key});

  bool get isSvg => asset?.endsWith('svg') == true;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: needPadding ? null : EdgeInsets.zero,
        onPressed: callback,
        child: SizedBox(
            width: sized ? 72 : null,
            child: Column(children: [
              Container(
                  height: 55,
                  width: 55,
                  padding: EdgeInsets.all(padding ?? 0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: NannyTheme.background,
                      boxShadow: withShadows
                          ? const [
                              BoxShadow(
                                  blurRadius: 8,
                                  color: Colors.black12,
                                  offset: Offset(0, 4))
                            ]
                          : null),
                  child: Center(child: child ?? (Icon(icon, size: 30)))),
              const SizedBox(height: 15),
              Text(label,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                      fontWeight: FontWeight.w400))
            ])));
  }
}

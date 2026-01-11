import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final String? description;
  final Widget trailing;
  final Widget? leading;
  final VoidCallback? onTap;
  final Widget? path;

  const SettingsTile({
    super.key,
    required this.title,
    this.trailing = const Icon(Icons.arrow_forward_ios_rounded),
    this.description,
    this.leading,
    this.onTap,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        minTileHeight: 0,
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.zero,
        leading: leading,
        title: Text(
          title,
          style: const TextStyle(
              color: Color(0xFF212121),
              fontSize: 18,
              fontWeight: FontWeight.w400),
        ),
        subtitle: description != null ? Text(description!) : null,
        trailing: trailing,
        onTap: path != null
            ? () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        path!,
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const Offset begin = Offset(1, 0);
                      const Offset end = Offset(0, 0);
                      final Tween<Offset> tween = Tween(begin: begin, end: end);
                      final CurveTween curve =
                          CurveTween(curve: Curves.easeInOut);

                      return SlideTransition(
                        position: animation.drive(tween.chain(curve)),
                        child: child,
                      );
                    },
                  ),
                )
            : onTap);
  }
}

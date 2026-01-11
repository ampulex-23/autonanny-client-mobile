import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanny_components/nanny_components.dart';

import '../styles/nanny_theme.dart';

class NannyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isTransparent;
  final bool hasBackButton;
  final bool isWhiteSystemBar;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final String? title;
  final Function()? onBackPressed;
  final Color? color;

  const NannyAppBar({
    super.key,
    this.isTransparent = true,
    this.hasBackButton = true,
    this.isWhiteSystemBar = true,
    this.actions,
    this.leading,
    this.bottom,
    this.title,
    this.color,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkBackground =
        (color ?? NannyTheme.background).computeLuminance() < 0.5;

    return AppBar(
      elevation: isTransparent ? 0 : 10,
      backgroundColor: color ??
          (isTransparent
              ? Colors.transparent
              : Theme.of(context).colorScheme.surface),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: color ?? NannyTheme.background,
        statusBarIconBrightness:
            isDarkBackground ? Brightness.light : Brightness.dark,
        statusBarBrightness:
            isDarkBackground ? Brightness.dark : Brightness.light,
      ),
      foregroundColor: NannyTheme.onSurface,
      forceMaterialTransparency: isTransparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      toolbarHeight: preferredSize.height,
      bottom: bottom,
      leading: leading != null
          ? Padding(
              padding: const EdgeInsets.only(left: 10),
              child: leading,
            )
          : (hasBackButton
              ? IconButton(
                  onPressed: onBackPressed != null
                      ? () => onBackPressed?.call()
                      : () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_outlined),
                  splashRadius: 25,
                )
              : null),
      actions: actions
        ?..add(
          const SizedBox(width: 10),
        ),
      title: title != null
          ? FittedBox(
              child: Text(title!,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center))
          : null,
      centerTitle: true,
      shadowColor: NannyTheme.shadow.withOpacity(.19),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, bottom == null ? 80 : 120);
}

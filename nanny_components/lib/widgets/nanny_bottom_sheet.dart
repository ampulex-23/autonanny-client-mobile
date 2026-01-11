import 'package:flutter/material.dart';
import 'package:nanny_components/styles/nanny_theme.dart';
import 'package:nanny_components/widgets/adapt_builder.dart';

class NannyBottomSheet extends StatelessWidget {
  final Widget child;
  final double? height;
  final bool roundBottom;

  const NannyBottomSheet({
    super.key,
    required this.child,
    this.height,
    this.roundBottom = false,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptBuilder(
      builder: (context, size) {
        return Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: NannyTheme.surface,
            borderRadius: roundBottom
                ? BorderRadius.circular(20)
                : const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
            boxShadow: [
              BoxShadow(
                color: NannyTheme.shadow.withOpacity(.19),
                blurRadius: 32,
                offset: const Offset(0, -2),
              )
            ],
          ),
          child: child,
        );
      },
    );
  }
}

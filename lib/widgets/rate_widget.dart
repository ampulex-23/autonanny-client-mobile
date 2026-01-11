import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';

class RateWidget extends StatelessWidget {
  final Function(int) tapCallback;
  final int selected;

  const RateWidget(
      {super.key, required this.tapCallback, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
            5,
            (i) => CupertinoButton(
                child: Icon(Icons.star,
                    color: i <= selected
                        ? NannyTheme.primary
                        : NannyTheme.background,
                    size: 40),
                onPressed: () => tapCallback(i))));
  }
}

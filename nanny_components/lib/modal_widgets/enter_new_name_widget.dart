import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class EnterNewNameWidget extends StatefulWidget {
  const EnterNewNameWidget(this.currentValue, {super.key});

  final String currentValue;

  @override
  State<EnterNewNameWidget> createState() => _EnterNewNameWidgetState();
}

class _EnterNewNameWidgetState extends State<EnterNewNameWidget> {
  late final controller = TextEditingController()..text = widget.currentValue;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Введите название",
          style: NannyTextStyles.nw70018.copyWith(fontSize: 24)),
      const SizedBox(height: 12),
      CupertinoTextField(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          controller: controller,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(color: Colors.black38))),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(children: [
            Expanded(
                child: ElevatedButton(
                    child: Text('Готово'),
                    onPressed: () =>
                        Navigator.of(context).pop(controller.text)))
          ]))
    ]);
  }
}

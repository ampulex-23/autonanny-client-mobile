import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';

class InfoView extends StatelessWidget {
  final String infoText;

  const InfoView({
    super.key,
    required this.infoText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              const Icon(Icons.info, color: NannyTheme.primary, size: 50),
              const SizedBox(height: 20),
              Text(infoText, softWrap: true),
            ],
          ),
        ),
      ),
    );
  }
}

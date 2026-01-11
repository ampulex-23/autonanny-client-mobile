import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';

class ErrorView extends StatelessWidget {
  final String errorText;
  
  const ErrorView({
    super.key,
    required this.errorText,
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
              const Icon(Icons.error_outline_rounded, color: NannyTheme.error, size: 50),
              const SizedBox(height: 20),
              Text(errorText, softWrap: true),
            ],
          ),
        ),
      ),
    );
  }
}
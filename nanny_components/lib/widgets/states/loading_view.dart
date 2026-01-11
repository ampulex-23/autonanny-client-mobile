import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final double? progress;
  const LoadingView({
    super.key,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(value: progress),
    );
  }
}
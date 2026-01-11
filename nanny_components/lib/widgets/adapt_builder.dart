import 'package:flutter/material.dart';

class AdaptBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Size size) builder;
  
  const AdaptBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return builder(context, size);
  }
}
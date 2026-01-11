import 'dart:async';

import 'package:flutter/material.dart';

class SmsTimer extends StatefulWidget {
  final int secFrom;
  final VoidCallback onEnd;

  const SmsTimer({
    super.key,
    required this.secFrom,
    required this.onEnd,
  });

  @override
  State<SmsTimer> createState() => _SmsTimerState();
}

class _SmsTimerState extends State<SmsTimer> {
  late Timer timer;
  
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1), 
      (timer) {
        if(widget.secFrom - timer.tick < 1) {
          widget.onEnd();
          timer.cancel();
        }

        setState(() {});
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
  
  @override
  Widget build(BuildContext context) {
    return Text("Повторная отправка будет возможна через: ${widget.secFrom - timer.tick} секунд", textAlign: TextAlign.center);
  }
}
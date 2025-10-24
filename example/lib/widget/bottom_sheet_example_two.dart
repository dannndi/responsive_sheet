import 'dart:async';

import 'package:flutter/material.dart';

class BottomSheetExampleTwo extends StatefulWidget {
  const BottomSheetExampleTwo({super.key});

  @override
  State<BottomSheetExampleTwo> createState() => _BottomSheetExampleTwoState();
}

class _BottomSheetExampleTwoState extends State<BottomSheetExampleTwo> {
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const interval = Duration(seconds: 1);
    _timer = Timer.periodic(interval, (_) {
      setState(() {
        _seconds += 1;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final seconds = _seconds.toString().padLeft(2, '0');
    return seconds;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _formattedTime,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

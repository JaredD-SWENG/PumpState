import 'dart:async';

import 'package:flutter/material.dart';

import '../classes/break.dart';

class PlayBreak extends StatefulWidget {
  final Function changeScreen;

  const PlayBreak({Key? key, required this.changeScreen}) : super(key: key);

  @override
  State<PlayBreak> createState() => _PlayBreakState();
}

class _PlayBreakState extends State<PlayBreak> {
  final Duration defaultBreak = const Duration(seconds: 1);
  late Timer timer;
  int counter = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(defaultBreak, (timer) {
      if (counter > 0) {
        handleTimer();
      } else {
        timer.cancel();
        widget.changeScreen();
      }
    });
  }

  handleTimer() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(counter.toString());
  }
}

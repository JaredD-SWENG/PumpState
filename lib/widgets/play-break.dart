import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../classes/break.dart';

class PlayBreak extends StatefulWidget {
  final Function changeScreen;

  const PlayBreak({Key? key, required this.changeScreen}) : super(key: key);

  @override
  State<PlayBreak> createState() => _PlayBreakState();
}

class _PlayBreakState extends State<PlayBreak> with TickerProviderStateMixin {
  final int defaultBreak = 15;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularCountDownTimer(
          width: 50,
          height: 50,
          duration: defaultBreak,
          initialDuration: 1,
          fillColor: Colors.black,
          ringColor: Colors.white,
          isReverse: false,
          onComplete: () {
            widget.changeScreen();
          },
        )
      ],
    ));
  }
}

import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import '../classes/activity.dart';
import '../classes/break.dart';

class PlayPause extends StatefulWidget {
  final Activity a;
  final Function changeScreen;

  const PlayPause({Key? key, required this.a, required this.changeScreen}) : super(key: key);

  @override
  State<PlayPause> createState() => _PlayPauseState();
}

class _PlayPauseState extends State<PlayPause> {
  late final int pauseTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Break b = widget.a as Break;
    pauseTime = b
        .getDuration()
        .inSeconds;
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
              duration: pauseTime,
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

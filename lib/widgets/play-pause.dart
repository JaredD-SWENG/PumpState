import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import '../classes/activity.dart';
import '../classes/break.dart';
import '../styles/styles.dart';

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
    pauseTime = b.getDuration().inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * .33, 0, MediaQuery.of(context).size.height * .33),
        child: CircularCountDownTimer(
          width: MediaQuery.of(context).size.width * .33,
          height: MediaQuery.of(context).size.width * .33,
          duration: pauseTime,
          textStyle: Theme.of(context).textTheme.headline5,
          initialDuration: 1,
          fillColor: creek(),
          ringColor: Colors.white,
          strokeWidth: 10,
          isReverse: false,
          onComplete: () {
            widget.changeScreen();
          },
        ));
  }
}

import 'dart:async';
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
  final Duration defaultBreak = const Duration(seconds: 1);
  late Timer timer;
  late int counter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init state called');
    Break b = widget.a as Break;
    counter = b.getDuration().inSeconds;
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
    print('rebuilt $counter');
    return Text(counter.toString());
  }
}

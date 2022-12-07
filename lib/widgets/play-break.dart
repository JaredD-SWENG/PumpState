import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../styles/styles.dart';

/// Plays a Break sequence from PlayWorkoutSequenceScreen
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
    return Container(
      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * .33, 0, MediaQuery.of(context).size.height * .33),
      child: CircularCountDownTimer(
        width: MediaQuery.of(context).size.width * .33,
        height: MediaQuery.of(context).size.width * .33,
        textStyle: Theme.of(context).textTheme.headline5,
        duration: defaultBreak,
        initialDuration: 1,
        fillColor: creek(),
        ringColor: Colors.white,
        strokeWidth: 10,
        isReverse: false,
        onComplete: () {
          widget.changeScreen();
        },
      ),
    );
  }
}

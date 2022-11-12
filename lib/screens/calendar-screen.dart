import 'package:flutter/material.dart';
import 'package:pump_state/screens/SchedulerScreen.dart';
import 'package:pump_state/styles/styles.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: linearGradient(),
      child: Center(
        child: SchedulerScreen(),
      ),
    );
  }
}

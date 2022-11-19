import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient()),
      child: Center(
        child: TableCalendar(
          firstDay: DateTime.utc(2022, 1, 1),
          lastDay: DateTime.utc(2022, 12, 31),
          focusedDay: DateTime.now(),
        ),
      ),
    );
  }
}

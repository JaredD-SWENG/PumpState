import 'package:flutter/material.dart';
import 'package:pump_state/styles/styles.dart';

import '../widgets/table-calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient(),
      ),
      child: Center(
        child: Calendar(),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/seven-day-pump-points-widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient()),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SevenDayPumpPoints(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

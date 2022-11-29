import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/this-week-pump-points-chart.dart';
import 'package:pump_state/widgets/this-week-workouts-completed.dart';

import '../widgets/next-scheduled-workout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient()),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                NextScheduledWorkout(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ThisWeekWorkoutsCompleted(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ThisWeekPumpPointsChart(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

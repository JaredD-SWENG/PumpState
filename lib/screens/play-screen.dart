import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/begin-workout-button.dart';
import 'package:pump_state/widgets/workouts-list.dart';

class PlayScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(decoration: linearGradient(), child: Column(children: [WorkoutsList(), BeginWorkoutButton()]));
  }
}

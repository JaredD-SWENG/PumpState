import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/begin-workout-button.dart';
import 'package:pump_state/widgets/workouts-list.dart';

import '../providers/config-provider.dart';

class PlayScreen extends ConsumerWidget {
  final Function changeScreen;

  const PlayScreen({Key? key, required this.changeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.read(configProvider).library.workouts.isEmpty) {
      return Container(
        decoration: BoxDecoration(gradient: backgroundGradient()),
        child: WorkoutsList(
          changeScreen: changeScreen,
        ),
      );
    } else {
      return Container(
          decoration: BoxDecoration(gradient: backgroundGradient()),
          child: Scrollbar(
              child: ListView(children: [
            WorkoutsList(
              changeScreen: changeScreen,
            ),
            BeginWorkoutButton(),
          ])));
    }
  }
}

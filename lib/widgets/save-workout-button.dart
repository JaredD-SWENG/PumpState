import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/workout-provider.dart';

import '../classes/config.dart';
import '../classes/file-io.dart';
import '../classes/workout.dart';

class SaveWorkoutButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          Config c = Config.newState(ref.read(configProvider).library, ref.read(configProvider).archive, ref.read(configProvider).scheduler);
          c.library.addWorkout(ref.read(workoutProvider));
          ref.read(configProvider.notifier).state = c;
          FileIO.writeConfig(ref.read(configProvider));
          ref.read(workoutProvider.notifier).state = Workout();
          Navigator.pop(context);
        },
        child: Text(
          'Save Workout',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

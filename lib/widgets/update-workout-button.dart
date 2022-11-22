import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/workout-provider.dart';

import '../classes/config.dart';
import '../classes/file-io.dart';
import '../classes/workout.dart';

class UpdateWorkoutButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    saveWorkout() {
      Config c = Config.newState(ref.read(configProvider.notifier).state.getLibrary(), ref.read(configProvider.notifier).state.getArchive(),
          ref.read(configProvider.notifier).state.getScheduler());
      Workout workout = c.findWorkout(ref.read(workoutProvider.notifier).state.getID()) as Workout;
      workout.setName(ref.read(workoutProvider).getName());
      workout.setFavorite(ref.read(workoutProvider).getFavorite());
      workout.setActivities(ref.read(workoutProvider).getActivityList());
      ref.read(configProvider.notifier).state = c;
      FileIO.writeConfig(ref.read(configProvider));
    }

    return Center(
      child: ElevatedButton(
        onPressed: () {
          saveWorkout();
          Navigator.pop(context);
        },
        child: Text(
          'Update Workout',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

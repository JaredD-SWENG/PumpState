import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/workout-provider.dart';

import '../classes/config.dart';
import '../classes/file-io.dart';
import '../classes/workout.dart';

/// UpdateWorkoutButton saves the changes made to a workout and updates state/local store
class UpdateWorkoutButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    saveWorkout() {
      Config c = Config.newState(ref.read(configProvider.notifier).state.getLibrary(), ref.read(configProvider.notifier).state.getArchive(),
          ref.read(configProvider.notifier).state.getScheduler()); // Create a new state
      Workout workout = c.findWorkout(ref.read(workoutProvider.notifier).state.getID()); // Find the workout
      workout.setName(ref.read(workoutProvider).getName()); // Set found workout's name
      workout.setFavorite(ref.read(workoutProvider).getFavorite()); // Set found workout's favorite
      workout.setActivities(ref.read(workoutProvider).getActivityList()); //  Set found workout's activity list
      ref.read(configProvider.notifier).state = c; // Set state
      FileIO.writeConfig(ref.read(configProvider)); // Update local store
    }

    return Center(
      child: ElevatedButton(
        onPressed: () {
          saveWorkout();
          Navigator.pop(context);
        },
        child: const Text(
          'Update Workout',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

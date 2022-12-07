import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/workout-provider.dart';

import '../classes/config.dart';
import '../classes/file-io.dart';
import '../classes/workout.dart';

/// Saves the configuration of a workout on edit/new
class SaveWorkoutButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          Config c = Config.newState(
              ref.read(configProvider).library, ref.read(configProvider).archive, ref.read(configProvider).scheduler); // Creates a new state
          c.library.addWorkout(ref.read(workoutProvider)); // Add the workout
          ref.read(configProvider.notifier).state = c; // Set config app state
          FileIO.writeConfig(ref.read(configProvider)); // Update local store
          ref.read(workoutProvider.notifier).state = Workout(); // Clear the workoutprovider
          Navigator.pop(context); // Pop the modal modal
        },
        child: const Text(
          'Save Workout',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

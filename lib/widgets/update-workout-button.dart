import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/workout-provider.dart';

import '../classes/config.dart';
import '../classes/file-io.dart';
import '../classes/workout.dart';
import 'error-card.dart';

/// UpdateWorkoutButton saves the changes made to a workout and updates state/local store
class UpdateWorkoutButton extends ConsumerWidget {
  const UpdateWorkoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    saveWorkout() {
      if (ref.read(workoutProvider).getName().isEmpty) {
        throw Exception('Workout must contain a name');
      } else if (ref.read(workoutProvider).activityListIsEmpty() || ref.read(workoutProvider).isFullOfBreaks()) {
        throw Exception('Workout must contain at least one exercise');
      } else {
        Config c = Config.newState(ref.read(configProvider.notifier).state.getLibrary(), ref.read(configProvider.notifier).state.getArchive(),
            ref.read(configProvider.notifier).state.getScheduler()); // Create a new state
        Workout workout = c.findWorkout(ref.read(workoutProvider.notifier).state.getID()); // Find the workout
        workout.setName(ref.read(workoutProvider).getName()); // Set found workout's name
        workout.setFavorite(ref.read(workoutProvider).getFavorite()); // Set found workout's favorite
        workout.setActivities(ref.read(workoutProvider).getActivityList()); //  Set found workout's activity list
        ref.read(configProvider.notifier).state = c; // Set state
        FileIO.writeConfig(ref.read(configProvider)); // Clear the workoutprovider
      }
    }

    void changeScreen(int i) {
      if (i == 0) {
        Navigator.pop(context);
      }
    }

    return Center(
      child: ElevatedButton(
        onPressed: () {
          try {
            saveWorkout();
            Navigator.pop(context);
          } catch (e) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ErrorCard(
                      changeScreen: changeScreen,
                      title: 'Warning',
                      body: e.toString(),
                      screenNumber: 0,
                      buttonText: 'Go Back',
                      closeOnButtonPress: false);
                });
          }
        },
        child: const Text(
          'Update Workout',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

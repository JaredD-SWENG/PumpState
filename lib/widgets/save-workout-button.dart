import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/workout-provider.dart';

import '../classes/config.dart';
import '../classes/file-io.dart';
import '../classes/workout.dart';
import 'error-card.dart';

/// Saves the configuration of a workout on edit/new
class SaveWorkoutButton extends ConsumerWidget {
  final String name;
  final int activityCount;
  final bool fullOfBreaks;

  const SaveWorkoutButton({super.key, required this.name, required this.activityCount, required this.fullOfBreaks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onSave() {
      if (name.isEmpty) {
        throw Exception('Workout must contain a name');
      } else if (activityCount == 0 || fullOfBreaks) {
        throw Exception('Workout must contain at least one exercise');
      } else {
        Config c = Config.newState(
            ref.read(configProvider).library, ref.read(configProvider).archive, ref.read(configProvider).scheduler); // Creates a new state
        c.library.addWorkout(ref.read(workoutProvider)); // Add the workout
        ref.read(configProvider.notifier).state = c; // Set config app state
        FileIO.writeConfig(ref.read(configProvider)); // Update local store
        ref.read(workoutProvider.notifier).state = Workout(); // Clear the workoutprovider
      }
    }

    void changeScreen(int i) {
      if (i == 0) {
        Navigator.pop(context);
      }
    }

    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          try {
            onSave();
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
                    closeOnButtonPress: false,
                  );
                });
          }
        },
        child: const Text(
          'Save Workout',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

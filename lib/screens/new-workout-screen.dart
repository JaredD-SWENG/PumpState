import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/new-workout-provider.dart';
import 'package:pump_state/widgets/break-buttons.dart';
import 'package:pump_state/widgets/exercise-dropdown.dart';
import 'package:pump_state/widgets/new-workout-activity-list.dart';
import 'package:pump_state/widgets/save-workout-button.dart';

import '../classes/workout.dart';

class NewWorkoutScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Workout'),
        ),
        body: Column(
          children: [
            TextFormField(
              onChanged: (s) {
                Workout w = Workout.createNew(ref.read(newWorkoutProvider).getID(), ref.read(newWorkoutProvider).getName(),
                    ref.read(newWorkoutProvider).getActivityList(), ref.read(newWorkoutProvider).getFavorite());
                w.setName(s);
                ref.read(newWorkoutProvider.notifier).state = w;
              },
            ),
            ExerciseDropdown(),
            BreakButtons(),
            NewWorkoutActivityList(),
            SaveWorkoutButton()
          ],
        ));
  }
}

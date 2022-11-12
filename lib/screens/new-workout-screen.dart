import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/new-workout-provider.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/break-buttons.dart';
import 'package:pump_state/widgets/exercise-dropdown.dart';
import 'package:pump_state/widgets/new-workout-activity-list.dart';
import 'package:pump_state/widgets/save-workout-button.dart';

import '../classes/workout.dart';

class NewWorkoutScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: linearGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(48, 47, 47, 1.0),
            title: Text('New Workout'),
          ),
          body: Column(
            children: <Widget>[
              TextFormField(
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(12),
                ],
                onChanged: (s) {
                  Workout w = Workout.createNew(ref.read(newWorkoutProvider).getID(), ref.read(newWorkoutProvider).getName(),
                      ref.read(newWorkoutProvider).getActivityList(), ref.read(newWorkoutProvider).getFavorite());
                  w.setName(s);
                  ref.read(newWorkoutProvider.notifier).state = w;
                },
              ),
              Expanded(
                  flex: 2,
                  child: ExerciseDropdown()),
              Expanded(
                  flex: 1,
                  child: BreakButtons()),
              Expanded(
                  flex: 12,
                  child: NewWorkoutActivityList()),
              Expanded(
                  flex: 1,
                  child: SaveWorkoutButton())
            ],
          )),
    );
  }
}

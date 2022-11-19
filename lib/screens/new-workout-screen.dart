import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
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
    Widget initDropDown;

    if (ref.read(configProvider).activitiesIsEmpty()) {
      initDropDown = const Text(
        'To add new Exercises to this workout, please create them in the Exercise Library.',
        style: TextStyle(
          color: Colors.red,
          backgroundColor: Color.fromRGBO(48, 47, 47, 1.0),
        ),
      );
    } else {
      initDropDown = ExerciseDropdown();
    }

    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient()),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
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
              Expanded(flex: 2, child: initDropDown),
              Expanded(flex: 1, child: BreakButtons()),
              Expanded(flex: 12, child: NewWorkoutActivityList()),
              Expanded(flex: 1, child: SaveWorkoutButton())
            ],
          )),
    );
  }
}

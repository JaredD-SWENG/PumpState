import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/workout-provider.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/break-buttons.dart';
import 'package:pump_state/widgets/exercise-dropdown.dart';
import 'package:pump_state/widgets/workout-activity-list.dart';
import 'package:pump_state/widgets/save-workout-button.dart';

import '../classes/workout.dart';

///NewWorkoutScreen is a View Model Widget used by the user when they are generating a New Workout.
class NewWorkoutScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget initDropDown;

    ///If the List of Activity is empty in configProvider, we output a Card to the User instructing them to create an Exercise before creating a workout,
    ///Otherwise, the Widget Object initDropDown is set to the ExerciseDropDown Widget.
    if (ref.read(configProvider).activitiesIsEmpty()) {
      initDropDown = const Text(
        'To add new Exercises to this workout, please create them in the Exercise Library.',
        style: TextStyle(
          color: Colors.red,
          backgroundColor: Color.fromRGBO(48, 47, 47, 1.0),
        ),
      );
    } else {
      initDropDown = const ExerciseDropdown();
    }

    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient()),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('New Workout'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                ref.read(workoutProvider.notifier).state = Workout();
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Column(
            children: <Widget>[
              TextFormField(
                ///Interactive Text Input Field, Updates the name of the Workout Object.
                inputFormatters: [
                  LengthLimitingTextInputFormatter(12),
                ],
                onChanged: (s) {
                  Workout w = Workout.createNew(ref.read(workoutProvider).getID(), ref.read(workoutProvider).getName(),
                      ref.read(workoutProvider).getActivityList(), ref.read(workoutProvider).getFavorite());
                  w.setName(s);
                  ref.read(workoutProvider.notifier).state = w;
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

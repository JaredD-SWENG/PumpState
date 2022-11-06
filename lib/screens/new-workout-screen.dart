import 'package:flutter/material.dart';
import 'package:pump_state/widgets/break-buttons.dart';
import 'package:pump_state/widgets/exercise-dropdown.dart';
import 'package:pump_state/widgets/new-workout-activity-list.dart';

class NewWorkoutScreen extends StatelessWidget {
  const NewWorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Workout'),
        ),
        body: Column(
          children: [ExerciseDropdown(), BreakButtons(), NewWorkoutActivityList()],
        ));
  }
}

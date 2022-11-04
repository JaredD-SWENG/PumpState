import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/new-workout-provider.dart';
import '../classes/exercise.dart';
import '../classes/workout.dart';

class ExerciseDropdown extends ConsumerStatefulWidget {
  const ExerciseDropdown({Key? key}) : super(key: key);

  @override
  ConsumerState<ExerciseDropdown> createState() => _ExerciseDropdownState();
}

class _ExerciseDropdownState extends ConsumerState<ExerciseDropdown> {
  late Exercise selectedExercise;

  @override
  void initState() {
    // TODO: implement initState
    selectedExercise = ref.read(configProvider).library.getActivitiesAsExercises().first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton(
          value: selectedExercise,
          items: ref.read(configProvider).library.getActivitiesAsExercises().map<DropdownMenuItem<Exercise>>((Exercise e) {
            return DropdownMenuItem<Exercise>(value: e, child: Text(e.getName()));
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedExercise = value!;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
              onPressed: () {
                Workout w = Workout.createNew(ref.read(newWorkoutProvider).getID(), ref.read(newWorkoutProvider).getName(),
                    ref.read(newWorkoutProvider).getActivityList(), ref.read(newWorkoutProvider).getFavorite());
                Exercise newExercise = Exercise.createNew(
                    selectedExercise.getName(), selectedExercise.getSets(), selectedExercise.getReps(), selectedExercise.getFavorite());
                w.addActivity(newExercise);
                ref.read(newWorkoutProvider.notifier).state = w;
              },
              child: Icon(Icons.add)),
        )
      ],
    );
  }
}

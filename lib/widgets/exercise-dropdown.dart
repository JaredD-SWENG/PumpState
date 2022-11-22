import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/workout-provider.dart';
import 'package:pump_state/styles/styles.dart';
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
    return Container(
      width: MediaQuery.of(context).size.width * .5,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Card(
        color: beaverBlue(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: selectedExercise,
              items: ref.read(configProvider).library.getActivitiesAsExercises().map<DropdownMenuItem<Exercise>>((Exercise e) {
                return DropdownMenuItem<Exercise>(
                    value: e,
                    child: Text(
                      e.getName(),
                      style: TextStyle(color: whiteOut()),
                    ));
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Workout w = Workout.createNew(ref.read(workoutProvider).getID(), ref.read(workoutProvider).getName(),
                        ref.read(workoutProvider).getActivityList(), ref.read(workoutProvider).getFavorite());
                    Exercise newExercise = Exercise.createNew(
                        selectedExercise.getName(), selectedExercise.getSets(), selectedExercise.getReps(), selectedExercise.getFavorite());
                    w.addActivity(newExercise);
                    ref.read(workoutProvider.notifier).state = w;
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

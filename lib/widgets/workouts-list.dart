import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/play-workout-provider.dart';
import 'package:pump_state/styles/styles.dart';

import '../classes/config.dart';
import '../classes/workout.dart';

class WorkoutsList extends ConsumerStatefulWidget {
  const WorkoutsList({Key? key}) : super(key: key);

  @override
  ConsumerState<WorkoutsList> createState() => _WorkoutsListState();
}

class _WorkoutsListState extends ConsumerState<WorkoutsList> {
  List<RadioListTile> radioListTiles = [];
  late Workout selectedWorkout;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Config c = ref.read(configProvider);
    if (c.library.workouts.isNotEmpty) {
      selectedWorkout = c.library.workouts[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    Config c = ref.read(configProvider);
    if (ref.read(configProvider).library.workouts.isEmpty) {
      return const Center(
          child: Text(
        'To play a workout, please create one in the workout Library.',
        style: TextStyle(
          color: Colors.red,
          backgroundColor: Color.fromRGBO(48, 47, 47, 1.0),
        ),
      ));
    } else {
      return Container(
          child: Column(children: <Widget>[
        for (Workout w in c.library.workouts)
          RadioListTile(
              title: Text(w.getName()),
              value: w,
              groupValue: selectedWorkout,
              onChanged: (value) {
                setState(() {
                  selectedWorkout = value!;
                  ref.read(playWorkoutProvider.notifier).state = selectedWorkout;
                  print(ref.read(playWorkoutProvider).getName());
                });
              })
      ]));
    }
  }
}

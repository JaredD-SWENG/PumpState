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
    selectedWorkout = c.library.workouts[0];
  }

  @override
  Widget build(BuildContext context) {
    Config c = ref.read(configProvider);
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
              });
            })
    ]));
  }
}

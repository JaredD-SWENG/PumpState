import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/play-workout-provider.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/error-card.dart';

import '../classes/config.dart';
import '../classes/workout.dart';

/// Generates a lit of workouts in the form of radio tiles for PlayScreen
class WorkoutsList extends ConsumerStatefulWidget {
  final Function changeScreen;

  const WorkoutsList({Key? key, required this.changeScreen}) : super(key: key);

  @override
  ConsumerState<WorkoutsList> createState() => _WorkoutsListState();
}

class _WorkoutsListState extends ConsumerState<WorkoutsList> {
  List<RadioListTile> radioListTiles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config c = ref.read(configProvider); // Read the config provider
    // If the config provider is empty
    if (ref.read(configProvider).library.workouts.isEmpty) {
      // Return the an error message
      return ErrorCard(
        changeScreen: widget.changeScreen,
        title: 'No workouts available',
        body: 'Please create a workout before playing one',
        screenNumber: 4,
        buttonText: 'Create Workout',
        closeOnButtonPress: false,
      );
    } else {
      // Return a list of workouts
      return Column(
        children: <Widget>[
          for (Workout w in c.library.workouts)
            RadioListTile(
                title: Text(
                  w.getName(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                activeColor: creek(),
                value: w,
                groupValue: ref.watch(playWorkoutProvider),
                onChanged: (value) {
                  setState(() {
                    ref.read(playWorkoutProvider.notifier).state = value!;
                  });
                })
        ],
      );
    }
  }
}

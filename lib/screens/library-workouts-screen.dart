import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/styles/styles.dart';

import '../classes/config.dart';
import '../classes/workout.dart';
import '../providers/config-provider.dart';

class LibraryWorkoutScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Workout> workouts = ref.watch(configProvider).library.workouts;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/new-workout');
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          decoration: linearGradient(),
          child: Center(
            child: Column(
              children: generateButtons(workouts, context, ref),
            ),
          ),
        ));
  }

  List<Widget> generateButtons(List<Workout> workouts, BuildContext context, WidgetRef ref) {
    List<Widget> listOfButtons = [];
    workouts.sort((a, b) {
      if (a.getFavorite()) {
        return -1;
      } else {
        return 1;
      }
    });
    for (Workout w in workouts) {
      Icon fav = Icon(Icons.star_border_outlined);
      if (w.getFavorite()) {
        fav = Icon(Icons.star);
      }
      ElevatedButton eb = ElevatedButton(
          onPressed: () {},
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
              onPressed: () {},
              icon: fav,
            ),
            Text(w.getName()),
          ]));
      listOfButtons.add(Padding(padding: EdgeInsets.all(5), child: eb));
    }
    return listOfButtons;
  }
}

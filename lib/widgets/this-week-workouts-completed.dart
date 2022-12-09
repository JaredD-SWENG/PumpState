import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';

import '../classes/completedWorkout.dart';
import '../styles/styles.dart';

/// Displays a analytics component of the workouts completed this week
class ThisWeekWorkoutsCompleted extends ConsumerWidget {
  const ThisWeekWorkoutsCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<CompletedWorkout> lcw = ref.read(configProvider).archive.thisWeeksCompletedWorkouts();

    return Container(
      width: MediaQuery.of(context).size.width * 0.50,
      height: MediaQuery.of(context).size.height * .19,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: nittanyNavy(),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Workouts Completed",
                  style: Theme.of(context).textTheme.headline5,
                ),
              )),
          Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${lcw.length}',
                  style: TextStyle(
                    color: creek(),
                    fontSize: 50,
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "This Week",
                  style: Theme.of(context).textTheme.headline6,
                ),
              )),
        ],
      ),
    );
  }
}

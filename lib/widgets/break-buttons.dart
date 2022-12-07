import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/workout-provider.dart';

import '../classes/break.dart';
import '../classes/workout.dart';
import '../styles/styles.dart';

///BreakButtons is a widget used when creating/editinga workout. This widget generates three buttons for the user,
///when pressed, each add a 30, 60, 90 second break into your workout respectively.
class BreakButtons extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const Text(
              '30',
              style: TextStyle(color: Colors.white),
            ),
            Transform.scale(
              scale: 1.25,
              child: IconButton(
                  color: creek(),
                  onPressed: () {
                    Workout w = Workout.createNew(ref.read(workoutProvider).getID(), ref.read(workoutProvider).getName(),
                        ref.read(workoutProvider).getActivityList(), ref.read(workoutProvider).getFavorite());
                    w.addActivity(Break(const Duration(seconds: 30)));
                    ref.read(workoutProvider.notifier).state = w;
                  },
                  icon: const Icon(Icons.circle_outlined)),
            )
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '60',
              style: TextStyle(
                color: whiteOut(),
              ),
            ),
            Transform.scale(
              scale: 1.25,
              child: IconButton(
                  color: creek(),
                  onPressed: () {
                    Workout w = Workout.createNew(ref.read(workoutProvider).getID(), ref.read(workoutProvider).getName(),
                        ref.read(workoutProvider).getActivityList(), ref.read(workoutProvider).getFavorite());
                    w.addActivity(Break(const Duration(seconds: 60)));
                    ref.read(workoutProvider.notifier).state = w;
                  },
                  icon: const Icon(Icons.circle_outlined)),
            )
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '90',
              style: TextStyle(
                color: whiteOut(),
              ),
            ),
            Transform.scale(
              scale: 1.25,
              child: IconButton(
                  color: creek(),
                  onPressed: () {
                    Workout w = Workout.createNew(ref.read(workoutProvider).getID(), ref.read(workoutProvider).getName(),
                        ref.read(workoutProvider).getActivityList(), ref.read(workoutProvider).getFavorite());
                    w.addActivity(Break(const Duration(seconds: 90)));
                    ref.read(workoutProvider.notifier).state = w;
                  },
                  icon: const Icon(Icons.circle_outlined)),
            )
          ],
        ),
      ],
    );
  }
}

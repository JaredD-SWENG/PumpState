import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/new-workout-provider.dart';

import '../classes/break.dart';
import '../classes/workout.dart';

class BreakButtons extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Text('30', style: TextStyle( color: Colors.white),),
            Transform.scale(
              scale: 1.25,
              child: IconButton(
                color: Colors.white,
                  onPressed: () {
                    Workout w = Workout.createNew(ref.read(newWorkoutProvider).getID(), ref.read(newWorkoutProvider).getName(),
                        ref.read(newWorkoutProvider).getActivityList(), ref.read(newWorkoutProvider).getFavorite());
                    w.addActivity(Break(const Duration(seconds: 30)));
                    ref.read(newWorkoutProvider.notifier).state = w;
                  },
                  icon: const Icon(Icons.circle_outlined)),
            )
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Text('60', style: TextStyle( color: Colors.white),),
            Transform.scale(
              scale: 1.25,
              child: IconButton(
                color: Colors.white,
                  onPressed: () {
                    Workout w = Workout.createNew(ref.read(newWorkoutProvider).getID(), ref.read(newWorkoutProvider).getName(),
                        ref.read(newWorkoutProvider).getActivityList(), ref.read(newWorkoutProvider).getFavorite());
                    w.addActivity(Break(const Duration(seconds: 60)));
                    ref.read(newWorkoutProvider.notifier).state = w;
                  },
                  icon: const Icon(Icons.circle_outlined)),
            )
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Text('90', style: TextStyle( color: Colors.white),),
            Transform.scale(
              scale: 1.25,
              child: IconButton(
                color: Colors.white,
                  onPressed: () {
                    Workout w = Workout.createNew(ref.read(newWorkoutProvider).getID(), ref.read(newWorkoutProvider).getName(),
                        ref.read(newWorkoutProvider).getActivityList(), ref.read(newWorkoutProvider).getFavorite());
                    w.addActivity(Break(const Duration(seconds: 90)));
                    ref.read(newWorkoutProvider.notifier).state = w;
                  },
                  icon: const Icon(Icons.circle_outlined)),
            )
          ],
        ),
      ],
    );
  }
}

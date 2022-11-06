import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/providers/new-workout-provider.dart';

import '../classes/activity.dart';
import '../classes/exercise.dart';
import '../classes/workout.dart';

class NewWorkoutActivityList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Workout w = ref.watch(newWorkoutProvider);
    List<Widget> listTiles = [];
    for (Activity a in w.getActivityList()) {
      ListTile lt = ListTile(tileColor: Colors.green, key: Key(a.getId()), title: Row(children: [Icon(Icons.drag_indicator), Text(a.getName())]));
      listTiles.add(lt);
    }
    return Theme(
        data: ThemeData(canvasColor: Colors.green),
        child: SizedBox(
            height: 500,
            child: ReorderableListView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                onReorder: (int oldIndex, int newIndex) {
                  if (newIndex > w.getActivityList().length) newIndex = w.getActivityList().length;
                  if (oldIndex < newIndex) newIndex--;
                  Workout workout = Workout.createNew(w.getID(), w.getName(), w.getActivityList(), w.getFavorite());
                  workout.reorderActivities(oldIndex, newIndex);
                  ref.read(newWorkoutProvider.notifier).state = workout;
                },
                children: listTiles)));
  }
}

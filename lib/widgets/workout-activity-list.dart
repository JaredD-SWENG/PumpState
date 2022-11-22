import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/providers/workout-provider.dart';

import '../classes/activity.dart';
import '../classes/exercise.dart';
import '../classes/workout.dart';
import '../styles/styles.dart';

class NewWorkoutActivityList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Workout w = ref.watch(workoutProvider);
    List<Widget> listTiles = [];
    for (Activity a in w.getActivityList()) {
      ListTile lt = ListTile(
        tileColor: Colors.transparent,
        key: Key(a.getId()),
        title: Row(children: [
          Icon(
            Icons.drag_indicator,
            color: creek(),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a.getName(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                if (a is Exercise)
                  Text(
                    'Sets: ${a.getSets().toString()} Reps: ${a.getReps().toString()}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
              ],
            ),
          )
        ]),
      );
      listTiles.add(lt);
    }
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: SizedBox(
        height: 500,
        child: RawScrollbar(
          thumbVisibility: true,
          thickness: 1.25,
          mainAxisMargin: 5,
          radius: const Radius.circular(5),
          crossAxisMargin: 38,
          thumbColor: whiteOut(),
          child: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            onReorder: (int oldIndex, int newIndex) {
              if (newIndex > w.getActivityList().length) {
                newIndex = w.getActivityList().length;
              }
              if (oldIndex < newIndex) newIndex--;
              Workout workout = Workout.createNew(w.getID(), w.getName(), w.getActivityList(), w.getFavorite());
              workout.reorderActivities(oldIndex, newIndex);
              ref.read(workoutProvider.notifier).state = workout;
            },
            children: <Widget>[
              for (int i = 0; i < listTiles.length; i++)
                Dismissible(
                  background: Container(
                    color: Colors.transparent,
                  ),
                  key: ValueKey(listTiles.elementAt(i)),
                  onDismissed: (DismissDirection horizontal) {
                    listTiles.removeAt(i);
                    Workout workout = Workout.createNew(ref.read(workoutProvider).getID(), ref.read(workoutProvider).getName(),
                        ref.read(workoutProvider).getActivityList(), ref.read(workoutProvider).getFavorite());
                    workout.removeActivityAt(i);
                    ref.read(workoutProvider.notifier).state = workout;
                  },
                  child: Card(
                    color: limestone(),
                    key: ValueKey(listTiles.elementAt(i)),
                    elevation: 2,
                    child: listTiles.elementAt(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';

import '../classes/activity.dart';
import '../classes/config.dart';
import '../classes/exercise.dart';
import '../classes/library.dart';
import '../providers/editExercise-provider.dart';
import '../widgets/edit-exercise-form.dart';

class LibraryActivitiesScreen extends ConsumerWidget {
  const LibraryActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Activity> activities = ref.watch(configProvider).library.activities;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Library/Activities'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/new-exercise'),
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: Column(
            children: generateButtons(activities, context, ref),
          ),
        ));
  }

  List<Widget> generateButtons(List<Activity> activities, BuildContext context, WidgetRef ref) {
    List<Widget> listOfButtons = [];
    activities.sort((a, b) {
      Exercise e1 = a as Exercise;
      if (e1.getFavorite()) {
        return -1;
      } else {
        return 1;
      }
    });
    for (Activity a in activities) {
      Exercise e = a as Exercise;
      Icon fav = Icon(Icons.favorite_outline);
      if (e.getFavorite()) {
        fav = Icon(Icons.favorite);
      }
      ElevatedButton eb = ElevatedButton(
        onPressed: () {
          print('test');
          ref.read(editExerciseProvider.notifier).state = e;
          showModalBottomSheet(context: context, builder: (context) => const EditExerciseForm());
        },
        child: Column(children: [
          Text(e.getName()),
          Text('Reps: ' + e.getReps().toString()),
          Text('Sets: ' + e.getSets().toString()),
          fav,
        ]),
      );
      listOfButtons.add(Padding(padding: EdgeInsets.all(5), child: eb));
    }
    return listOfButtons;
  }
}

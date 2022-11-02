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
        title: Text('Library/Activities'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/new-exercise'),
        child: Icon(Icons.add),
      ),
      body: Center(
          child: Column(
        children: generateButtons(activities, context, ref),
      )),
    );
  }

  List<Widget> generateButtons(List<Activity> activities, BuildContext context, WidgetRef ref) {
    List<Widget> listOfButtons = [];
    for (Activity a in activities) {
      Exercise e = a as Exercise;
      ElevatedButton eb = ElevatedButton(
          onPressed: () {
            ref.read(editExerciseProvider.notifier).state = e;
            showModalBottomSheet(context: context, builder: (context) => EditExerciseForm());
          },
          child: Text(e.getName()));
      listOfButtons.add(eb);
    }
    return listOfButtons;
  }
}

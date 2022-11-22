import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/styles/styles.dart';

import '../classes/activity.dart';
import '../classes/config.dart';
import '../classes/exercise.dart';
import '../classes/file-io.dart';
import '../providers/exercise-provider.dart';
import '../widgets/edit-exercise-form.dart';

class LibraryActivitiesScreen extends ConsumerWidget {
  const LibraryActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Activity> activities = ref.watch(configProvider).library.activities;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/new-exercise'),
          child: const Icon(Icons.add),
        ),
        body: Container(
            decoration: BoxDecoration(gradient: backgroundGradient()),
            child: Center(
                child: Scrollbar(
                    child: ListView(
              children: generateButtons(activities, context, ref),
            )))));
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
      Icon fav = const Icon(
        Icons.star_border_outlined,
      );
      if (e.getFavorite()) {
        fav = Icon(
          Icons.star,
          color: creek(),
        );
      }
      ListTile eb = ListTile(
          iconColor: Colors.white,
          textColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Config c = Config.newState(ref.read(configProvider.notifier).state.getLibrary(),
                            ref.read(configProvider.notifier).state.getArchive(), ref.read(configProvider.notifier).state.getScheduler());
                        Exercise exercise = c.findActivity(ref.read(exerciseProvider.notifier).state.getId()) as Exercise;
                        e.toggleFavorite();
                        ref.read(configProvider.notifier).state = c;
                        ref.read(exerciseProvider.notifier).state = exercise;
                        FileIO.writeConfig(ref.read(configProvider));
                      },
                      icon: fav,
                    ),
                    IconButton(
                        onPressed: () {
                          ref.read(exerciseProvider.notifier).state = e;
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => const EditExerciseForm(),
                          );
                        },
                        icon: Icon(Icons.edit, color: creek())),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  e.getName(),
                  softWrap: false,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Sets'),
                  Text(
                    e.getSets().toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Reps'),
                  Text(
                    e.getReps().toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            ],
          ));
      listOfButtons.add(Dismissible(
          background: Container(
            color: const Color.fromRGBO(48, 47, 47, 1.0),
          ),
          onDismissed: (DismissDirection horizontal) {
            listOfButtons.remove(eb);
            Config c = Config.newState(ref.read(configProvider.notifier).state.getLibrary(), ref.read(configProvider.notifier).state.getArchive(),
                ref.read(configProvider.notifier).state.getScheduler());
            c.library.removeActivity(e.getId());
            ref.read(configProvider.notifier).state = c;
            FileIO.writeConfig(ref.read(configProvider));
          },
          key: ValueKey(eb),
          child: eb));
    }
    return listOfButtons;
  }
}

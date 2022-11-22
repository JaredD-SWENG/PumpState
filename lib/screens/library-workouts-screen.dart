import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/workout-provider.dart';
import 'package:pump_state/screens/new-workout-screen.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/edit-workout-form.dart';

import '../classes/activity.dart';
import '../classes/config.dart';
import '../classes/file-io.dart';
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
          decoration: BoxDecoration(gradient: backgroundGradient()),
          child: Center(
            child: Scrollbar(
                child: ListView(
              children: generateButtons(workouts, context, ref),
            )),
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
      print(w.getSizeOfActivityList());
      Icon fav = Icon(Icons.star_border_outlined);
      if (w.getFavorite()) {
        fav = Icon(
          Icons.star,
          color: creek(),
        );
      }

      ListTile lt = ListTile(
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
                      Workout workout = c.findWorkout(w.getID());
                      workout.toggleFavorite();
                      ref.read(configProvider.notifier).state = c;
                      FileIO.writeConfig(ref.read(configProvider));
                    },
                    icon: fav,
                  ),
                  IconButton(
                      onPressed: () {
                        ref.read(workoutProvider.notifier).state =
                            Workout.createNew(w.getID(), w.getName(), w.getActivityList().toList(), w.getFavorite());
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return const EditWorkoutForm();
                          },
                        ).whenComplete(() {
                          ref.read(workoutProvider.notifier).state = Workout();
                        });
                      },
                      icon: Icon(Icons.edit, color: creek())),
                ],
              ),
            ),
            Expanded(
              child: Text(
                w.getName(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Activities '),
                    Text(
                      w.getSizeOfActivityList().toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Text.rich(
                  TextSpan(
                    text: 'Pauses ',
                    children: [
                      TextSpan(
                        text: w.getSumOfBreaks().toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                        children: const [
                          TextSpan(text: ' min', style: TextStyle(fontWeight: FontWeight.normal)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      );
      listOfButtons.add(Dismissible(
          background: Container(
            color: Color.fromRGBO(48, 47, 47, 1.0),
          ),
          key: ValueKey(w),
          onDismissed: (DismissDirection horizontal) {
            listOfButtons.remove(w);
            Config c = Config.newState(ref.read(configProvider.notifier).state.getLibrary(), ref.read(configProvider.notifier).state.getArchive(),
                ref.read(configProvider.notifier).state.getScheduler());
            c.library.removeWorkout(w.getID());
            ref.read(configProvider.notifier).state = c;
            FileIO.writeConfig(ref.read(configProvider));
          },
          child: lt));
    }
    return listOfButtons;
  }
}

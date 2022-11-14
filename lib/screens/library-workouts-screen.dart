import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/styles/styles.dart';

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
      /*ElevatedButton eb = ElevatedButton(
          onPressed: () {},
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
              onPressed: () {},
              icon: fav,
            ),
            Text(w.getName()),
          ]));*/

      ListTile lt = ListTile(
        iconColor: Colors.white,
        textColor: Colors.white,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            IconButton(onPressed: (){ return;}, icon: Icon(Icons.edit, color: Colors.white)), //Placeholder for when we implement edit workout
            Text(w.getName()),
          ],
        ),
      );
      listOfButtons.add(Dismissible(
        background: Container(
          color: Color.fromRGBO(48, 47, 47, 1.0),
        ),
          key: ValueKey(w),
          onDismissed: (DismissDirection horizontal){
            listOfButtons.remove(w);
            Config c = Config.newState(ref.read(configProvider.notifier).state.getLibrary(),
                ref.read(configProvider.notifier).state.getArchive(), ref.read(configProvider.notifier).state.getScheduler());
            c.library.removeWorkout(w.getID());
            ref.read(configProvider.notifier).state = c;
            FileIO.writeConfig(ref.read(configProvider));
          },
          child: Padding(padding: EdgeInsets.all(5), child: lt)));
    }
    return listOfButtons;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/workout-provider.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/edit-workout-form.dart';

import '../classes/config.dart';
import '../classes/file-io.dart';
import '../classes/workout.dart';
import '../providers/config-provider.dart';
import '../widgets/error-card.dart';

/// LibraryWorkoutScreen displays the Workouts that have been saved in Config>Library
/// Uses ephemeral state
class LibraryWorkoutScreen extends ConsumerWidget {
  final Function changeScreen;

  const LibraryWorkoutScreen({Key? key, required this.changeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Workout> workouts = ref.watch(configProvider).library.workouts;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (ref.read(configProvider).library.activities.isEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorCard(
                      changeScreen: changeScreen,
                      title: 'No exercises available',
                      body: 'Please create an exercise before configuring a workout',
                      screenNumber: 3,
                      buttonText: 'Create Exercise',
                      closeOnButtonPress: true,
                    );
                  });
            } else {
              Navigator.pushNamed(context, '/new-workout');
            }
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

  /// Generates each saved workout as a card that is dismissible, editable and favoritable
  List<Widget> generateButtons(List<Workout> workouts, BuildContext context, WidgetRef ref) {
    List<Widget> listOfButtons = [];
    // Places favorite at the top
    workouts.sort((a, b) {
      if (a.getFavorite()) {
        return -1;
      } else {
        return 1;
      }
    });
    for (Workout w in workouts) {
      Icon fav = const Icon(Icons.star_border_outlined);
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
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Activities '),
                    Text(
                      w.getSizeOfActivityList().toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Text.rich(
                  TextSpan(
                    text: 'Pauses ',
                    children: [
                      TextSpan(
                        text: w.getSumOfBreaks().toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
            listOfButtons.remove(w); // Remove buttons
            Config c = Config.newState(ref.read(configProvider.notifier).state.getLibrary(), ref.read(configProvider.notifier).state.getArchive(),
                ref.read(configProvider.notifier).state.getScheduler());
            c.library.removeWorkout(w.getID()); // Remove workout from state
            ref.read(configProvider.notifier).state = c; // Reset state
            FileIO.writeConfig(ref.read(configProvider)); // Update local store
          },
          child: lt));
    }
    return listOfButtons;
  }
}

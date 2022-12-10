import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/exercise-provider.dart';
import 'package:pump_state/styles/styles.dart';
import '../classes/config.dart';
import '../classes/exercise.dart';
import '../classes/file-io.dart';

///EditExerciseForm is the View Model responsible for implementing all logic for when a user edits a exercise.
class EditExerciseForm extends ConsumerWidget {
  const EditExerciseForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///Each parameter is set to the parameters found in the Exercise instance stored in the exerciseProvider.
    String _id = ref.watch(exerciseProvider).getId();
    String _name = ref.watch(exerciseProvider).getName();
    int _sets = ref.watch(exerciseProvider).getSets();
    int _reps = ref.watch(exerciseProvider).getReps();
    bool _favorite = ref.watch(exerciseProvider).getFavorite();

    ///incrementSets increments the total sets, then updates the exerciseProvider.
    void incrementSets() {
      Exercise e = Exercise.updateState(_id, _name, ++_sets, _reps, _favorite);
      ref.read(exerciseProvider.notifier).state = e;
    }

    ///decrementSets decrements the total sets, then updates the exerciseProvider.
    void decrementSets() {
      if (_sets == 0) return;

      ///if sets is 0, return.

      Exercise e = Exercise.updateState(_id, _name, --_sets, _reps, _favorite);
      ref.read(exerciseProvider.notifier).state = e;
    }

    ///incrementReps increments the total reps, then updates the exerciseProvider.
    void incrementReps() {
      Exercise e = Exercise.updateState(_id, _name, _sets, ++_reps, _favorite);
      ref.read(exerciseProvider.notifier).state = e;
    }

    ///decrementReps decrements the total reps, then updates the exerciseProvider.
    void decrementReps() {
      if (_reps == 0) return;

      ///if reps is 0, return.

      Exercise e = Exercise.updateState(_id, _name, _sets, --_reps, _favorite);
      ref.watch(exerciseProvider.notifier).state = e;
    }

    ///toggleFavorite switches the favorite parameter from true to false, or from false to true, then updates the exerciseProvider.
    void toggleFavorite(bool b) {
      Exercise e = Exercise.updateState(_id, _name, _sets, _reps, b);
      ref.watch(exerciseProvider.notifier).state = e;
    }

    ///setName function sets the name of the exercise, then updates the exerciseProvider.
    void setName(String s) {
      _name = s;
      Exercise e = Exercise.updateState(_id, _name, _sets, _reps, _favorite);
      ref.watch(exerciseProvider.notifier).state = e;
    }

    ///saveExercise, saves the exercise, by updating the configProvider to contain the newly configured exercise.
    ///Then, it writes the new data to file using the FileIO object.
    saveExercise() {
      if (_name.isEmpty) {
        throw Exception('Name cannot be blank.');
      } else if (_sets == 0) {
        throw Exception('Sets must be a non-zero number.');
      } else if (_reps == 0) {
        throw Exception('Reps must be a non-zero number.');
      } else {
        Config c = Config.newState(ref.read(configProvider.notifier).state.getLibrary(), ref.read(configProvider.notifier).state.getArchive(),
            ref.read(configProvider.notifier).state.getScheduler());
        Exercise exercise = c.findActivity(ref.read(exerciseProvider.notifier).state.getId()) as Exercise;
        exercise.setName(_name);
        exercise.setSets(_sets);
        exercise.setReps(_reps);
        exercise.setFavorite(_favorite);
        ref.read(configProvider.notifier).state = c;
        ref.read(exerciseProvider.notifier).state = exercise;
        FileIO.writeConfig(ref.read(configProvider));
      }
    }

    ///addRep is a Button Widget, that when pressed calls the incrementReps function.
    Widget addRep = IconButton(
      onPressed: incrementReps,
      icon: Icon(
        Icons.add_circle,
        color: whiteOut(),
      ),
    );

    ///removeRep is a Button Widget, that when pressed calls the decrementReps function.
    Widget removeRep = IconButton(
      onPressed: decrementReps,
      icon: Icon(
        Icons.remove_circle,
        color: whiteOut(),
      ),
    );

    ///exerciseName is a TextFormField widget, that when changed, calls the setName function.
    Widget exerciseName = TextFormField(
      textAlign: TextAlign.center,
      style: TextStyle(color: whiteOut()),
      inputFormatters: [
        new LengthLimitingTextInputFormatter(12),
      ],
      decoration: const InputDecoration(
        hintText: "Exercise name",
      ),
      enabled: true,
      onChanged: setName,
      initialValue: _name,
    );

    ///setDisplay is a Text widget used to display the current number of sets to the User.
    Widget setDisplay = Text(
      _sets.toString(),
      style: TextStyle(fontSize: 20, color: whiteOut()),
    );

    ///addSet is a button widget that, when pressed, calls the incrementSets function.
    Widget addSet = IconButton(
      onPressed: incrementSets,
      icon: Icon(
        Icons.add_circle,
        color: whiteOut(),
      ),
    );

    ///removeSet is a button widget that, when pressed, calls the decrementSets function.
    Widget removeSet = IconButton(
      onPressed: decrementSets,
      icon: Icon(
        Icons.remove_circle,
        color: whiteOut(),
        shadows: [Shadow(color: Colors.black, blurRadius: 1)],
      ),
    );

    ///repsDisplay is a text widget that displays the current total of reps to the user.
    Widget repsDisplay = Text(
      _reps.toString(),
      style: TextStyle(fontSize: 20, color: whiteOut()),
    );

    ///favoriteToggle is a Switch Widget that when pressed, calls the toggleFavorite function.
    Widget favoriteToggle = Switch(value: _favorite, onChanged: toggleFavorite);

    ///saveButton is a button widget that, when pressed, calls the saveExercise function. Then Exits this screen.
    Widget saveButton = ElevatedButton(
        onPressed: () {
          saveExercise();

          Navigator.pop(context);
        },
        child: const Text("Save"));

    ///The Container returned here is a culmination of all thw widget's custom made in this file put together.
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: slate()),
        height: MediaQuery.of(context).size.height * 0.45,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            child:
            Row(
                children: [
              Container(
                  width: MediaQuery.of(context).size.width * .5,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Card(
                      color: beaverBlue(),
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        Text('Name', style: Theme.of(context).textTheme.headline5),
                        exerciseName,
                      ]))),
              Container(
                  width: MediaQuery.of(context).size.width * .5,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ]),
                  child: Card(
                      color: beaverBlue(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text('Favorite', style: Theme.of(context).textTheme.headline5), favoriteToggle],
                      ))),
            ]),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width * .5,
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ]),
                      child: Card(
                          color: beaverBlue(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Sets', style: Theme.of(context).textTheme.headline5),
                              setDisplay,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [addSet, removeSet],
                              )
                            ],
                          ))),
                ),
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width * .5,
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ]),
                      child: Card(
                          color: beaverBlue(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Reps', style: Theme.of(context).textTheme.headline5),
                              repsDisplay,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [addRep, removeRep],
                              )
                            ],
                          ))),
                ),
              ],
            ),
          ),
          saveButton,
        ]));
  }
}

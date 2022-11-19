import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/editExercise-provider.dart';
import 'package:pump_state/styles/styles.dart';
import '../classes/config.dart';
import '../classes/exercise.dart';
import '../classes/file-io.dart';

class EditExerciseForm extends ConsumerWidget {
  const EditExerciseForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String _id = ref.watch(editExerciseProvider).getId();
    String _name = ref.watch(editExerciseProvider).getName();
    int _sets = ref.watch(editExerciseProvider).getSets();
    int _reps = ref.watch(editExerciseProvider).getReps();
    bool _favorite = ref.watch(editExerciseProvider).getFavorite();

    void incrementSets() {
      Exercise e = Exercise.updateState(_id, _name, ++_sets, _reps, _favorite);
      ref.read(editExerciseProvider.notifier).state = e;
    }

    void decrementSets() {
      if (_sets == 0) return;

      Exercise e = Exercise.updateState(_id, _name, --_sets, _reps, _favorite);
      ref.read(editExerciseProvider.notifier).state = e;
    }

    void incrementReps() {
      Exercise e = Exercise.updateState(_id, _name, _sets, ++_reps, _favorite);
      ref.read(editExerciseProvider.notifier).state = e;
    }

    void decrementReps() {
      if (_reps == 0) return;

      Exercise e = Exercise.updateState(_id, _name, _sets, --_reps, _favorite);
      ref.watch(editExerciseProvider.notifier).state = e;
    }

    void toggleFavorite(bool b) {
      Exercise e = Exercise.updateState(_id, _name, _sets, _reps, b);
      ref.watch(editExerciseProvider.notifier).state = e;
    }

    void setName(String s) {
      _name = s;
      Exercise e = Exercise.updateState(_id, _name, _sets, _reps, _favorite);
      ref.watch(editExerciseProvider.notifier).state = e;
    }

    saveExercise() {
      Config c = Config.newState(ref.read(configProvider.notifier).state.getLibrary(), ref.read(configProvider.notifier).state.getArchive(),
          ref.read(configProvider.notifier).state.getScheduler());
      Exercise exercise = c.findActivity(ref.read(editExerciseProvider.notifier).state.getId()) as Exercise;
      exercise.setName(_name);
      exercise.setSets(_sets);
      exercise.setReps(_reps);
      exercise.setFavorite(_favorite);
      ref.read(configProvider.notifier).state = c;
      ref.read(editExerciseProvider.notifier).state = exercise;
      FileIO.writeConfig(ref.read(configProvider));
    }

    Widget addRep = IconButton(
      onPressed: incrementReps,
      icon: Icon(
        Icons.add_circle,
        color: whiteOut(),
      ),
    );

    Widget removeRep = IconButton(
      onPressed: decrementReps,
      icon: Icon(
        Icons.remove_circle,
        color: whiteOut(),
      ),
    );

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

    Widget setDisplay = Text(
      _sets.toString(),
      style: TextStyle(fontSize: 20, color: whiteOut()),
    );

    Widget addSet = IconButton(
      onPressed: incrementSets,
      icon: Icon(
        Icons.add_circle,
        color: whiteOut(),
      ),
    );

    Widget removeSet = IconButton(
      onPressed: decrementSets,
      icon: Icon(
        Icons.remove_circle,
        color: whiteOut(),
        shadows: [Shadow(color: Colors.black, blurRadius: 1)],
      ),
    );

    Widget repsDisplay = Text(
      _reps.toString(),
      style: TextStyle(fontSize: 20, color: whiteOut()),
    );

    Widget favoriteToggle = Switch(value: _favorite, onChanged: toggleFavorite);

    Widget saveButton = ElevatedButton(
        onPressed: () {
          saveExercise();

          Navigator.pop(context);
        },
        child: const Text("Save"));

    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: slate()),
        height: MediaQuery.of(context).size.height * 0.33,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(children: [
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
          Row(
            children: [
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
            ],
          ),
          saveButton,
        ]));
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/editExercise-provider.dart';
import '../classes/config.dart';
import '../classes/exercise.dart';

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
      Config c = Config.newState(
          ref.read(configProvider.notifier).state.getLibrary(),
          ref.read(configProvider.notifier).state.getArchive(),
          ref.read(configProvider.notifier).state.getScheduler());
      Exercise exercise =
          c.findActivity(ref.read(editExerciseProvider.notifier).state.getId())
              as Exercise;
      exercise.setName(_name);
      exercise.setSets(_sets);
      exercise.setReps(_reps);
      exercise.setFavorite(_favorite);

      ref.read(configProvider.notifier).state = c;
      ref.read(editExerciseProvider.notifier).state = exercise;
    }

    Widget addRep =
        ElevatedButton(onPressed: incrementReps, child: const Text("Add Rep"));

    Widget removeRep = ElevatedButton(
        onPressed: decrementReps, child: const Text("Remove Rep"));

    Widget exerciseName = TextFormField(
      decoration: const InputDecoration(
        hintText: "Exercise name",
      ),
      enabled: true,
      onChanged: setName,
      initialValue: _name,
    );

    Widget SetDisplay = Text(
      _sets.toString(),
      style: const TextStyle(
        fontSize: 20,
      ),
    );

    Widget addSet =
        ElevatedButton(onPressed: incrementSets, child: const Text("Add Set"));

    Widget removeSet = ElevatedButton(
        onPressed: decrementSets, child: const Text("Remove Set"));

    Widget exerciseReps = Text(
      _reps.toString(),
      style: const TextStyle(
        fontSize: 20,
      ),
    );

    Widget favoriteToggle = Switch(value: _favorite, onChanged: toggleFavorite);

    Widget exerciseFavoriteText = const Text(
        style: TextStyle(
          fontSize: 20,
        ),
        "Favorite");

    Widget saveButton = ElevatedButton(
        onPressed: () {
          saveExercise();

          Navigator.pop(context);
        },
        child: const Text("Save"));

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          exerciseName,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SetDisplay,
              addSet,
              removeSet,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [exerciseReps, addRep, removeRep],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [exerciseFavoriteText, favoriteToggle],
          ),
          saveButton,
        ],
      ),
    );
  }
}

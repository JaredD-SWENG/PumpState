import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import '../classes/config.dart';
import '../classes/exercise.dart';

class ExerciseForm extends ConsumerStatefulWidget {
  @override
  ExerciseFormState createState() => ExerciseFormState();
}

class ExerciseFormState extends ConsumerState<ExerciseForm> {
  String _name = "";
  int _sets = 0;
  int _reps = 0;
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    void setName(String s) {
      setState(() {
        _name = s;
      });
    }

    void incrementSets() {
      setState(() {
        _sets++;
      });
    }

    void decrementSets() {
      setState(() {
        if(_sets == 0) return;
        _sets--;
      });
    }

    void incrementReps() {
      setState(() {
        _reps++;
      });
    }

    void decrementReps() {
      setState(() {
        if(_reps == 0) return;
        _reps--;
      });
    }

    void toggleFavorite(bool b) {
      setState(() {
        _favorite = b;
      });
    }

    Future<void> saveExercise() async {
      // Get the current config
      Config c = ref.watch(configProvider);
      Exercise e = Exercise.createNew(_name, _sets, _reps, _favorite);
      c.library.addActivity(e);
      ref.read(configProvider.notifier).state = c;
    }

    Widget exerciseName = TextFormField(
      decoration: const InputDecoration(
        hintText: "Exercise name",
      ),
      onChanged: setName,
      initialValue: _name,
    );

    Widget exerciseSets = Text(
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

    Widget addRep =
        ElevatedButton(onPressed: incrementReps, child: const Text("Add Rep"));

    Widget removeRep = ElevatedButton(
        onPressed: decrementReps, child: const Text("Remove Rep"));

    Widget exerciseFavoriteText = const Text(
        style: TextStyle(
          fontSize: 20,
        ),
        "Favorite");

    Widget favoriteToggle = Switch(value: _favorite, onChanged: toggleFavorite);

    Widget saveButton = ElevatedButton(
        onPressed: () {
          saveExercise().then((result) => {Navigator.pop(context)});
        },
        child: const Text("Save"));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        exerciseName,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            exerciseSets,
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
    );
  }
}

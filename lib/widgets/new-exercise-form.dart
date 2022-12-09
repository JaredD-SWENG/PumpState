import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/error-card.dart';
import '../classes/config.dart';
import '../classes/exercise.dart';
import '../classes/file-io.dart';

///NewExerciseForm is the view model responsible for implementing UI and logic for when the User is creating a new exercise.
class NewExerciseForm extends ConsumerStatefulWidget {
  @override
  ExerciseFormState createState() => ExerciseFormState();
}

class ExerciseFormState extends ConsumerState<NewExerciseForm> {
  String _name = "";
  int _sets = 0;
  int _reps = 0;
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    ///setName sets the name of the Exercise.
    void setName(String s) {
      setState(() {
        _name = s;
      });
    }

    ///incrementSets increments the sets parameter.
    void incrementSets() {
      setState(() {
        _sets++;
      });
    }

    ///decrementSets decrements the sets parameter.
    void decrementSets() {
      setState(() {
        if (_sets == 0) return;

        ///if sets = 0, return.
        _sets--;
      });
    }

    ///incrementReps increments the reps parameter.
    void incrementReps() {
      setState(() {
        _reps++;
      });
    }

    ///decrementReps decrements the reps paramater.
    void decrementReps() {
      setState(() {
        if (_reps == 0) return;

        ///if reps = 0, return.
        _reps--;
      });
    }

    ///toggleFavorite changes the favorite parameter from true to false, or from false to true.
    void toggleFavorite(bool b) {
      setState(() {
        _favorite = b;
      });
    }

    ///saveExercise Adds a new Exercise to the configPRovider passing in the currently configured paramaters in, name, sets, reps, name, and favorite.
    ///After adding to configProvider, it calls the FileIO Object to write the new data to file.
    void saveExercise() {
      if (_name.isEmpty) {
        throw Exception('Name cannot be blank.');
      } else if (_sets == 0) {
        throw Exception('Sets must be a non-zero number.');
      } else if (_reps == 0) {
        throw Exception('Reps must be a non-zero number.');
      } else {
        Config c = Config.newState(ref.read(configProvider).library, ref.read(configProvider).archive, ref.read(configProvider).scheduler);
        Exercise e = Exercise.createNew(_name, _sets, _reps, _favorite);
        c.library.addActivity(e);
        ref.read(configProvider.notifier).state = c;
        FileIO.writeConfig(ref.read(configProvider));
      }
    }

    ///exerciseName is a TextFormField Widget that alters the name parameter to match the string stored in the widget.
    Widget exerciseName = TextFormField(
      decoration: const InputDecoration(
        hintText: "Exercise name",
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(12),

        ///String length capped to 12 letters.
      ],
      onChanged: setName,
      initialValue: _name,
    );

    ///exerciseSets is a Text widget that displays the current number of sets.
    Widget exerciseSets = Text(
      _sets.toString(),
      style: const TextStyle(
        fontSize: 20,
      ),
    );

    ///addSet is a button widget that, when pressed, calls the incrementSets function.
    Widget addSet = ElevatedButton(onPressed: incrementSets, child: const Text("Add Set"));

    ///removeSet is a button that, when pressed, calls the decrementSets function.
    Widget removeSet = ElevatedButton(onPressed: decrementSets, child: const Text("Remove Set"));

    ///exerciseReps is a text widget that displays the current number of reps to the user.
    Widget exerciseReps = Text(
      _reps.toString(),
      style: const TextStyle(
        fontSize: 20,
      ),
    );

    ///addRep is a button widget that, when pressed, calls the increment reps function.
    Widget addRep = ElevatedButton(onPressed: incrementReps, child: const Text("Add Rep"));

    ///removeRep is a button widget that, when pressed, calls the decrementReps function.
    Widget removeRep = ElevatedButton(onPressed: decrementReps, child: const Text("Remove Rep"));

    ///exerciseFavoriteText is a text widget that displays the word "Favorite" to the User.
    Widget exerciseFavoriteText = const Text(
        style: TextStyle(
          fontSize: 20,
        ),
        "Favorite");

    ///favoriteToggle is a Switch widget that, when pressed, calls the toggleFavorite function.
    Widget favoriteToggle = Switch(value: _favorite, onChanged: toggleFavorite);

    void changeScreen(int i) {
      if (i == 0) {
        Navigator.pop(context);
      }
    }

    ///saveButton is a button widget that, when pressed, calls the saveExercise function.
    Widget saveButton = ElevatedButton(
        onPressed: () {
          try {
            saveExercise();
            Navigator.pop(context);
          } catch (e) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ErrorCard(
                    changeScreen: changeScreen,
                    title: 'Warning',
                    body: e.toString(),
                    screenNumber: 0,
                    buttonText: 'Go Back',
                    closeOnButtonPress: false);
              },
            );
          }
        },
        child: const Text("Save"));

    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient()),
      child: Column(
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
      ),
    );
  }
}

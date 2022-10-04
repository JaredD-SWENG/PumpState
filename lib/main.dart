import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/classes/exercise.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pump_state/classes/library.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget newExercise = ExerciseForm();

    return MaterialApp(
        title: 'Pump State',
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo[900],
              title: const Text('PumpState'),
            ),
            body: ListView(
              children: [
                newExercise,
              ],
            )));
  }
}

class ExerciseForm extends StatefulWidget {
  const ExerciseForm({Key? key}) : super(key: key);

  @override
  State<ExerciseForm> createState() => _ExerciseFormState();
}

class _ExerciseFormState extends State<ExerciseForm> {
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
        _reps--;
      });
    }

    void toggleFavorite(bool b) {
      setState(() {
        _favorite = b;
      });
    }

    Future<void> saveExercise() async {
      // see if exercise library exists
      // if it doesn't create exercise library
      // if it does exist create a json blob
      // add json blob to exercise library

      Exercise exercise = Exercise(_name, _sets, _reps, _favorite);
      Directory dir = await getApplicationDocumentsDirectory();
      String exLibPath = "${dir.path}/exerciseLibrary.json";

      // if the file is not found
      if (!File(exLibPath).existsSync()) {
        // create a new library
        Library lib = Library();
        // store the exercise in the library
        lib.addActivity(exercise);
        // convert the library to json
        var libJson = lib.toJson().toString();
        // create the file
        File file = File(exLibPath);
        // write the library to the file
        file.writeAsStringSync(libJson);
        if (kDebugMode) {
          print(libJson);
        }
      }

      // if the file is found
      else {
        // open the file
        File file = File(exLibPath);
        // read the library
        var libJsonRead = file.readAsStringSync();
        // convert the library to json (Map<String, dynamic>)
        var lib = jsonDecode(libJsonRead);
        // convert json to Library
        Library l = Library.fromJson(lib);
        l.addActivity(exercise);
        // convert the library back to json
        var libJsonWrite = l.toJson().toString();
        // overwrite the file
        file.writeAsStringSync(libJsonWrite);
        if (kDebugMode) {
          print(file.readAsStringSync());
        }
      }
    }

    Widget exerciseName = TextFormField(
      decoration: const InputDecoration(
        hintText: "Exercise name",
      ),
      onChanged: setName,
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

    Widget saveButton =
        ElevatedButton(onPressed: saveExercise, child: const Text("Save"));

    return Column(
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

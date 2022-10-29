import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/classes/completedWorkout.dart';
import 'package:pump_state/classes/workout.dart';
import '../widgets/edit-exercise-form.dart';
import 'activity.dart';
import 'exercise.dart';
import 'scheduler.dart';
import 'library.dart';
import 'archive.dart';

import 'package:flutter/material.dart';
import 'package:pump_state/providers/editExercise-provider.dart';

class Config {
  late Library library;
  late Archive archive;
  late Scheduler scheduler;

  Config() {
    library = Library();
    archive = Archive();
    scheduler = Scheduler();
  }

  Config.fromJson(Map<String, dynamic> map) {
    map.forEach((key, value) {
      switch (key) {
        case "library":
          library = Library.fromJson(value);
          break;
        case "archive":
          archive = Archive.fromJson(value);
          break;
        case "scheduler":
          scheduler = Scheduler.fromJson(value);
          break;
      }
    });
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map();
    map['library'] = library.toJson();
    map['archive'] = archive.toJson();
    map['scheduler'] = scheduler.toJson();
    return map;
  }

  void listLibrary() {
    List<Workout> workouts = library.getWorkouts();
    for (Workout w in workouts) {
      print(w.getName());
    }
  }

  void listArchive() {
    List<CompletedWorkout> cw = archive.getCompletedWorkouts();
    print(cw.length);
    for (CompletedWorkout d in cw) {
      print(d.getPumpPoints());
    }
  }

  void callSchedulerPrint() {
    scheduler.printScheduledWorkouts();
  }

  List<Widget> getLibraryActivitiesAsButtons(context, WidgetRef ref) {
    List<Widget> listOfButtons = [];
    for (Activity a in library.getlistofactivities()) {
      Exercise e = a as Exercise;
      ElevatedButton eb = ElevatedButton(
          onPressed: () {
            ref.read(editExerciseProvider.state).state = e;
            showModalBottomSheet(
                context: context, builder: (context) => EditExerciseForm());
          },
          child: Text(e.getName()));
      listOfButtons.add(eb);
    }
    return listOfButtons;
  }

  Activity findActivity(String s) {
    Activity activity = Exercise();
    for (Activity a in library.getlistofactivities()) {
      if (s == a.getId()) {
        activity = a as Exercise;
        return activity;
      }
    }
    return activity;
  }
}

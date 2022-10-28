import 'package:pump_state/classes/completedWorkout.dart';
import 'package:pump_state/classes/workout.dart';
import 'scheduler.dart';
import 'library.dart';
import 'archive.dart';
import 'scheduler.dart';
import 'dart:convert';
import 'completedWorkout.dart';

class Config {
  late Library _library;
  late Archive _archive;

  late Scheduler _scheduler;

  Config();

  Config.fromJson(Map<String, dynamic> map) {
    map.forEach((key, value) {
      switch (key) {
        case "library":
          _library = Library.fromJson(value);
          break;
        case "archive":
          _archive = Archive.fromJson(value);
          break;
        case "scheduler":
          _scheduler = Scheduler.fromJson(value);
          break;
      }
    });
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map();
    map['library'] = _library.toJson();
    map['archive'] = _archive.toJson();
    map['scheduler'] = _scheduler.toJson();
    return map;
  }

  void listLibrary() {
    List<Workout> workouts = _library.getWorkouts();
    for (Workout w in workouts) {
      print(w.getName());
    }
  }

  void listArchive() {
    List<CompletedWorkout> cw = _archive.getCompletedWorkouts();
    print(cw.length);
    for (CompletedWorkout d in cw) {
      print(d.getPumpPoints());
    }
  }

  void callSchedulerPrint() {
    _scheduler.printScheduledWorkouts();
  }
}

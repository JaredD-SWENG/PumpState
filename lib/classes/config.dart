import 'package:pump_state/classes/completedWorkout.dart';
import 'package:pump_state/classes/workout.dart';
import 'scheduler.dart';
import 'library.dart';
import 'archive.dart';
import 'scheduler.dart';
import 'dart:convert';
import 'completedWorkout.dart';

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
}

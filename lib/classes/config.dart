import 'package:pump_state/classes/workout.dart';
import 'activity.dart';
import 'exercise.dart';
import 'scheduler.dart';
import 'library.dart';
import 'archive.dart';

/// Config holds all data within application
class Config {
  late Library library;
  late Archive archive;
  late Scheduler scheduler;

  /// Default constructor
  Config() {
    library = Library();
    archive = Archive();
    scheduler = Scheduler();
  }

  /**
   * newState() is a constructor designed for use when updating State Providers.
   * You pass in the current instances of library, archive, and scheduler to a new instance of Config
   * This is needed because otherwise, if we do not instantiate a new object of Config, out state provider
   * will not know if/when the config is altered, or at the very least UI will not change.
   */
  Config.newState(Library lib, Archive arch, Scheduler sched) {
    library = lib;
    archive = arch;
    scheduler = sched;
  }

  /// Constructor to generate Object from JSON
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

  /// Generates a JSON string of Config
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map();
    map['library'] = library.toJson();
    map['archive'] = archive.toJson();
    map['scheduler'] = scheduler.toJson();
    return map;
  }

  /// findActivity()
  /// This method takes in an ID parameter, which is used to find that specific instance of Exercise stored in the library,
  /// we then retur that instance of exercise to be altered/rewritten.
  /// Currently used in:
  /// library-activities-screen.dart
  Activity findActivity(String s) {
    Activity activity = Exercise();
    for (Activity a in library.activities) {
      if (s == a.getId()) {
        activity = a as Exercise;
        return activity;
      }
    }
    return activity;
  }

  /// findWorkout()
  /// This method takes in an ID parameter, which is used to find that specific instance
  /// of Workout stored in the library, then return that instance of workout
  /// to be altered/rewritten. Currently used in: library-workouts-screen.dart
  Workout findWorkout(String s) {
    Workout workout = Workout();
    for (Workout w in library.workouts) {
      if (s == w.getID()) {
        workout = w;
        return workout;
      }
    }
    return workout;
  }

  /// Returns true if Library is empty, false otherwise
  bool activitiesIsEmpty() {
    return library.activitiesIsEmpty();
  }

  /// Return current instance library
  /// currently used for newState() Constructor.
  getLibrary() {
    return library;
  }

  /// Return current instance archive
  /// currently used for newState() Constructor.
  getArchive() {
    return archive;
  }

  /// Return current instance scheduler.
  /// currently used for newState() Constructor.
  getScheduler() {
    return scheduler;
  }
}

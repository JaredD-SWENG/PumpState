import 'package:pump_state/classes/exercise.dart';
import 'activity.dart';
import 'workout.dart';

/// Library holds configuration for saved exercises and workouts
class Library {
  List<Activity> activities = []; //Exercises
  List<Workout> workouts = []; //Workouts

  /// Default constructor
  Library();

  /// Constructor to generate object from JSON
  Library.fromJson(Map<String, dynamic> map) {
    map.forEach((key, value) {
      switch (key) {
        case "workouts":
          for (dynamic d in value) {
            Workout w = Workout.fromJSON(d);
            workouts.add(w);
          }
          break;
        case "activities":
          for (dynamic d in value) {
            Exercise e = Exercise.fromJson(d);
            activities.add(e);
          }
          break;
      }
    });
  }

  /// Generates a JSON string of Config
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['workouts'] = workouts.map((i) => i.toJson()).toList();
    map['activities'] = activities.map((i) => (i as Exercise).toJson()).toList();
    return map;
  }

  /// Adds Activity to list of activities
  void addActivity(Activity activity) {
    activities.add(activity);
  }

  /// Returns a list of workouts
  List<Workout> getWorkouts() {
    return workouts;
  }

  /// Returns the list of activities as exercises
  List<Exercise> getActivitiesAsExercises() {
    List<Exercise> exercises = [];
    for (Activity a in activities) {
      Exercise e = a as Exercise;
      exercises.add(e);
    }
    return exercises;
  }

  /// Adds a workout to the workouts list
  addWorkout(Workout w) {
    workouts.add(w);
  }

  /// Returns true if no activities in activity list, false otherwise
  bool activitiesIsEmpty() {
    return activities.isEmpty;
  }

  /// Accepts a string s as parameter where s is the Id of the
  /// activity to be removed from the list of activities
  removeActivity(String s) {
    for (int i = 0; i < activities.length; i++) {
      if (s == activities[i].getId()) {
        activities.removeAt(i);
      }
    }
  }

  /// Accepts a string s as parameter where s is the Id of the
  /// workout to be removed from the list of workouts
  removeWorkout(String s) {
    for (int i = 0; i < workouts.length; i++) {
      if (s == workouts[i].getID()) {
        workouts.removeAt(i);
      }
    }
  }
}

import 'package:pump_state/classes/exercise.dart';
import 'dart:convert';
import 'activity.dart';
import 'workout.dart';
import 'exercise.dart';

class Library {
  List<Activity> activities = []; //Exercises
  List<Workout> _workouts = []; //Workouts

  Library();

  Library.fromJson(Map<String, dynamic> map) {
    map.forEach((key, value) {
      switch (key) {
        case "workouts":
          //print('HI!');
          //print(value);
          for (dynamic d in value) {
            Workout w = Workout.fromJSON(d);
            _workouts.add(w);
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['workouts'] = _workouts.map((i) => i.toJson()).toList();
    map['activities'] = activities.map((i) => (i as Exercise).toJson()).toList();
    return map;
  }

  void addActivity(Activity activity) {
    activities.add(activity);
  }

  List<Workout> getWorkouts() {
    return _workouts;
  }
}

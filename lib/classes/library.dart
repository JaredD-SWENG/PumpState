import 'package:pump_state/classes/exercise.dart';
import 'dart:convert';
import 'activity.dart';
import 'workout.dart';

class Library {
  List<Activity> _activities = [];
  List<Workout> _workouts = [];

  Library();

  Library.fromJson(Map<String, dynamic> map) {
    map.forEach((key, value) {
      switch (key) {
        case "workouts":
          print('HI!');
          print(value);
          for (dynamic d in value) {
            Workout w = Workout.fromJSON(d);
            _workouts.add(w);
          }
          break;
        case "activites":
          for (dynamic d in value) {
            Exercise e = Exercise.fromJson(d);
            _activities.add(e);
          }
          break;
      }
    });
  }

  Map<String, List> toJson() {
    Map<String, List> json = {
      "\"activities\"": _activities.map((a) => jsonEncode(a)).toList()
    };
    return json;
  }

  void addActivity(Activity activity) {
    _activities.add(activity);
  }

  String exercise1Id() {
    var test = _activities.elementAt(0) as Exercise;
    return test.getId();
  }

  List<Workout> getWorkouts() {
    return _workouts;
  }
}

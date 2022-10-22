import 'activity.dart';
import 'package:uuid/uuid.dart';
import 'break.dart';
import 'exercise.dart';

class Workout {
  String _id = '';
  String _name = '';
  List<Activity> _activities = [];
  bool _favorite = false;

  Workout() {
    _id = const Uuid().v4();
  }

  getID() {
    return _id;
  }

  getName() {
    return _name;
  }

  setName(String name) {
    _name = name;
  }

  getActivity(int i) {
    return _activities[i];
  }

  getActivityList() {
    return _activities;
  }

  addActivity(Activity A) {
    _activities.add(A);
  }

  removeActivity(String id) {
    for (Activity a in _activities) {
      if (a.getId() == id) {
        _activities.remove(a);
      }
    }
  }

  toggleFavorite() {
    if (_favorite == false) {
      _favorite = true;
    } else {
      _favorite = false;
    }
  }

  Workout.fromJSON(Map<String, dynamic> json) {
    for (dynamic d in json['activities']) {
      if (d.containsKey('duration')) {
        Break b = Break.fromJson(d);
        _activities.add(b);
      } else {
        Exercise e = Exercise.fromJson(d);
        _activities.add(e);
      }
    }
    _id = json['id'];
    _name = json['name'];
    if (json['favorite'] == "true") {
      _favorite = true;
    } else {
      _favorite = false;
    }
  }
}

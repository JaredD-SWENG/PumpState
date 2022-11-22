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

  Workout.createNew(String id, String name, List<Activity> activities, bool favorite) {
    _id = id;
    _name = name;
    _activities = activities;
    _favorite = favorite;
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

  reorderActivities(int oldIndex, int newIndex) {
    _activities.insert(newIndex, _activities.removeAt(oldIndex));
  }

  getActivityList() {
    return _activities;
  }

  getSizeOfActivityList() {
    return _activities.length;
  }

  getActivityID(int n) {
    return _activities[n].getId();
  }

  getActivityName(int n) {
    return _activities[n].getName();
  }

  setActivities(List<Activity> la) {
    _activities = la;
  }

  getSumOfBreaks() {
    int result = 0;
    for (Activity a in _activities) {
      if (a is Break) {
        Break b = a;
        result += b
            .getDuration()
            .inMinutes;
      }
    }
    return result;
  }

  addActivity(Activity a) {
    _activities.add(a);
  }

  removeActivity(String id) {
    for (Activity a in _activities) {
      if (a.getId() == id) {
        _activities.remove(a);
      }
    }
  }

  removeActivityAt(int n) {
    _activities.removeAt(n);
  }

  getFavorite() {
    return _favorite;
  }

  setFavorite(bool b) {
    _favorite = b;
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['activities'] = _activities.map((i) => i.toJson()).toList();
    map['name'] = _name;
    map['id'] = _id;
    map['favorite'] = _favorite.toString();
    return map;
  }
}

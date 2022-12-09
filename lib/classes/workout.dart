import 'activity.dart';
import 'package:uuid/uuid.dart';
import 'break.dart';
import 'exercise.dart';

/// Workout defines a group of activities which can be sequences of Breaks and Exercise
class Workout {
  String _id = '';
  String _name = '';
  List<Activity> _activities = [];
  bool _favorite = false;

  /// Default constructor
  Workout() {
    _id = const Uuid().v4();
  }

  /// Creates a new instance of Workout with new key, used for provider state
  Workout.createNew(String id, String name, List<Activity> activities, bool favorite) {
    _id = id;
    _name = name;
    _activities = activities;
    _favorite = favorite;
  }

  /// Constructor to generate object from JSON
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

  /// Generates a JSON string of Config
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['activities'] = _activities.map((i) => i.toJson()).toList();
    map['name'] = _name;
    map['id'] = _id;
    map['favorite'] = _favorite.toString();
    return map;
  }

  bool isFullOfBreaks() {
    for (Activity a in _activities) {
      if (a is Exercise) return false;
    }
    return true;
  }

  bool activityListIsEmpty() {
    return _activities.isEmpty;
  }

  /// Returns the Id of this workout
  getID() {
    return _id;
  }

  /// Returns the name of this workout
  getName() {
    return _name;
  }

  /// Sets the name of this workout
  setName(String name) {
    _name = name;
  }

  /// Gets an activity from the activities list at index i
  getActivity(int i) {
    return _activities[i];
  }

  /// Reorders the activities in the list
  reorderActivities(int oldIndex, int newIndex) {
    _activities.insert(newIndex, _activities.removeAt(oldIndex));
  }

  /// Returns the list of activities
  getActivityList() {
    return _activities;
  }

  /// Returns the size of the activity list
  getSizeOfActivityList() {
    return _activities.length;
  }

  /// Sets the activity list to a new activity list
  setActivities(List<Activity> la) {
    _activities = la;
  }

  /// Returns the total break time for a workout sequence
  getSumOfBreaks() {
    int result = 0;
    for (Activity a in _activities) {
      if (a is Break) {
        Break b = a;
        result += b.getDuration().inMinutes;
      }
    }
    return result;
  }

  /// Adds an activity to the activity list
  addActivity(Activity a) {
    _activities.add(a);
  }

  /// Removes an activity from the activity list with id passed as parameter
  removeActivity(String id) {
    for (Activity a in _activities) {
      if (a.getId() == id) {
        _activities.remove(a);
      }
    }
  }

  /// Removes an activity at a given position n
  removeActivityAt(int n) {
    _activities.removeAt(n);
  }

  /// Returns true if favorite, false otherwise
  getFavorite() {
    return _favorite;
  }

  /// Sets favorite to parameter b
  setFavorite(bool b) {
    _favorite = b;
  }

  /// Toggles this workout of favorite
  toggleFavorite() {
    if (_favorite == false) {
      _favorite = true;
    } else {
      _favorite = false;
    }
  }
}

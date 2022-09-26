import 'package:pump_state/classes/exercise.dart';
import 'dart:convert';
import 'activity.dart';

class Library{
  List<Activity> _activities = [];

  Library();

  Library.fromJson(Map<String, dynamic> data) {
    // note the explicit cast to String
    // this is required if robust lint rules are enabled
    var activityObjsJson = data['exercises'] as List;
    _activities = activityObjsJson.map((activityJson) => Exercise.fromJson(activityJson)).toList();
  }

  Map<String, List> toJson(){
    Map<String, List> json = {
      "\"exercises\"" : _activities.map((a) => jsonEncode(a)).toList()
    };
    return json;
  }

  void addActivity(Activity activity){
    _activities.add(activity);
  }

  String exercise1Id(){
    var test = _activities.elementAt(0) as Exercise;
    return test.getId();
  }
}
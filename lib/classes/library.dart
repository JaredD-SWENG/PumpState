import 'package:pump_state/classes/exercise.dart';
import 'dart:convert';
import 'activity.dart';
import 'workout.dart';
import 'exercise.dart';

class Library {
  List<Activity> activities = []; //Exercises
  List<Workout> workouts = []; //Workouts

  Library();

  Library.fromJson(Map<String, dynamic> map) {
    map.forEach((key, value) {
      switch (key) {
        case "workouts":
        //print('HI!');
        //print(value);
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['workouts'] = workouts.map((i) => i.toJson()).toList();
    map['activities'] = activities.map((i) => (i as Exercise).toJson()).toList();
    return map;
  }

  void addActivity(Activity activity) {
    activities.add(activity);
  }

  List<Workout> getWorkouts() {
    return workouts;
  }

  List<Exercise> getActivitiesAsExercises() {
    List<Exercise> exercises = [];
    for (Activity a in activities) {
      Exercise e = a as Exercise;
      exercises.add(e);
    }
    return exercises;
  }

  addWorkout(Workout w) {
    workouts.add(w);
  }

  bool activitiesIsEmpty(){

    return activities.isEmpty;
  }

  removeActivity(String s){
    for(int i = 0; i < activities.length; i++){
      if(s == activities[i].getId()){
        activities.removeAt(i);
      }
    }
  }

  removeWorkout(String s){
    for(int i = 0; i < workouts.length; i++){
      if(s == workouts[i].getID()){
        workouts.removeAt(i);
      }
    }
  }
}

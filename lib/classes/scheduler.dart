import 'package:flutter/material.dart';
import 'package:pump_state/classes/scheduledWorkout.dart';
import 'workout.dart';

/// Scheduler holds a list of all scheduled workouts
class Scheduler {
  List<ScheduledWorkout> _scheduledWorkout = []; //Object to store Date / Workout to be stored.

  /// Default constructor
  Scheduler();

  /// Constructor to generate object from JSON
  Scheduler.fromJson(Map<String, dynamic> map) {
    for (dynamic item in map['scheduledWorkouts']) {
      ScheduledWorkout sw = ScheduledWorkout(item['scheduledDate'], Workout.fromJSON(item['scheduledWorkout']));
      _scheduledWorkout.add(sw);
    }
  }

  /// Generates a JSON string of Config
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map();
    map['scheduledWorkouts'] = _scheduledWorkout.map((i) => i.toJson()).toList();
    return map;
  }

  /// Adds a scheduled workout to the list of scheduled workouts
  void scheduleWorkout(ScheduledWorkout sw) {
    _scheduledWorkout.add(sw);
  }

  /// Returns the list of scheduled workouts
  List<ScheduledWorkout> getSchedule() {
    return _scheduledWorkout;
  }

  /// Returns the next scheduled workout
  /// Operates as a min function
  ScheduledWorkout nextScheduledWorkout() {
    ScheduledWorkout nextScheduledWorkout = _scheduledWorkout[0];
    for (ScheduledWorkout s in _scheduledWorkout) {
      if (s.scheduledDate.isBefore(nextScheduledWorkout.getDate())) {
        nextScheduledWorkout = s;
      }
    }
    return nextScheduledWorkout;
  }

  /// Returns all the scheduled workouts that occur on parameter DateTime d
  List<ScheduledWorkout> getSW(DateTime d) {
    List<ScheduledWorkout> lsw = [];
    for (ScheduledWorkout sw in _scheduledWorkout) {
      if (DateUtils.isSameDay(d, sw.getDate())) {
        lsw.add(sw);
      }
    }
    return lsw;
  }
}

import 'package:flutter/material.dart';
import 'package:pump_state/classes/workout.dart';
import 'package:uuid/uuid.dart';

class ScheduledWorkout {
  late DateTime scheduledDate;
  late Workout scheduledWorkout;

  ScheduledWorkout(String d, Workout w) {
    scheduledDate = DateTime.parse(d);
    scheduledWorkout = w;
  }

  ScheduledWorkout.fromCalendar(DateTime d, Workout w) {
    scheduledDate = d;
    scheduledWorkout = w;
  }

  getDate() {
    return scheduledDate;
  }

  getWorkout() {
    return ScheduledWorkout;
  }

  bool isScheduledWorkoutOnDate(DateTime d) {
    if (DateUtils.isSameDay(d, scheduledDate)) {
      return true;
    } else {
      return false;
    }
  }

  getName() {
    return scheduledWorkout.getName();
  }

  Map<String, dynamic> toJson() => {'scheduledDate': scheduledDate.toString(), 'scheduledWorkout': scheduledWorkout.toJson()};
}

import 'package:flutter/material.dart';
import 'package:pump_state/classes/workout.dart';

/// Scheduled stores a date and workout that has been scheduled
class ScheduledWorkout {
  late DateTime scheduledDate;
  late Workout scheduledWorkout;

  /// Constructor to create a ScheduledWorkout.
  /// Accepts date as string and a workout as parameters
  ScheduledWorkout(String d, Workout w) {
    scheduledDate = DateTime.parse(d);
    scheduledWorkout = w;
  }

  /// Constructor to create a ScheduledWorkout
  /// Accepts date as DateTime and a workout as parameters
  ScheduledWorkout.fromCalendar(DateTime d, Workout w) {
    scheduledDate = d;
    scheduledWorkout = w;
  }

  /// Generates a JSON string of Config
  Map<String, dynamic> toJson() => {'scheduledDate': scheduledDate.toString(), 'scheduledWorkout': scheduledWorkout.toJson()};

  /// Returns the date of scheduled workout
  getDate() {
    return scheduledDate;
  }

  /// Returns the workout scheduled
  getWorkout() {
    return ScheduledWorkout;
  }

  /// Returns the name of the scheduled workout
  getName() {
    return scheduledWorkout.getName();
  }

  /// Returns true if a this scheduled workout is on accepted parameter DateTime d
  bool isScheduledWorkoutOnDate(DateTime d) {
    if (DateUtils.isSameDay(d, scheduledDate)) {
      return true;
    } else {
      return false;
    }
  }

  String getFormattedDate() {
    String temp = "";
    temp += scheduledDate.month.toString();
    temp += "/";
    temp += scheduledDate.day.toString();
    temp += "/";
    temp += scheduledDate.year.toString();
    return temp;
  }
}

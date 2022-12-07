import 'package:flutter/material.dart';

/// CompletedWorkout records the date and pump points of a workout once it has been played through (completed)
class CompletedWorkout {
  DateTime _date = DateTime.now();
  int _pumpPoints = 0;

  /// Constructor used to create a new piece of state for riverpod.
  /// Operates by assigning a new Key to the widget.
  CompletedWorkout.createNew(this._date, this._pumpPoints);

  /// Constructor to generate object. Used in reading from json
  CompletedWorkout(String s, String pumpPoints) {
    _date = DateTime.parse(s);
    _pumpPoints = int.parse(pumpPoints);
  }

  /// Generates a JSON string of CompletedWorkout
  Map<String, dynamic> toJson() => {'date': _date.toString(), 'points': _pumpPoints.toString()};

  /// Returns the date of the completed workout
  DateTime getDate() {
    return _date;
  }

  /// Returns the pump points for an instance of completed workout
  int getPumpPoints() {
    return _pumpPoints;
  }

  /// Returns true if this completed workout occured this week, false if not.
  /// A week is defined by Sunday through Saturday
  bool isThisWeek() {
    DateTime now = DateUtils.dateOnly(DateTime.now());
    // Get monday of this week
    DateTime mondayThisWeek = now.subtract(Duration(days: now.weekday));
    // If date is after or equal to Monday of this week
    if (DateUtils.dateOnly(_date).isAfter(mondayThisWeek) || DateUtils.isSameDay(mondayThisWeek, _date)) {
      return true;
    } else {
      return false;
    }
  }
}

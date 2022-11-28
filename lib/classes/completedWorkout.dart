import 'package:flutter/material.dart';

class CompletedWorkout {
  DateTime _date = DateTime.now();
  int _pumpPoints = 0;

  CompletedWorkout.createNew(this._date, this._pumpPoints);

  CompletedWorkout(String s, String pumpPoints) {
    _date = DateTime.parse(s);
    _pumpPoints = int.parse(pumpPoints);
  }

  int getPumpPoints() {
    return _pumpPoints;
  }

  bool isThisWeek() {
    DateTime now = DateUtils.dateOnly(DateTime.now());
    // Get monday of this week
    DateTime mondayThisWeek = now.subtract(Duration(days: now.weekday));
    if (DateUtils.dateOnly(_date).isAfter(mondayThisWeek) || DateUtils.isSameDay(mondayThisWeek, _date)) {
      return true;
    } else {
      return false;
    }
  }

  DateTime getDate() {
    return _date;
  }

  Map<String, dynamic> toJson() => {'date': _date.toString(), 'points': _pumpPoints.toString()};
}

import 'package:uuid/uuid.dart';
import 'workout.dart';
import 'completedWorkout.dart';

class Archive {
  List<CompletedWorkout> _completedWorkouts = [];

  Archive();

  Archive.fromJson(Map<String, dynamic> map) {
    for (dynamic item in map['completedWorkouts']) {
      CompletedWorkout cw = CompletedWorkout(item['date'], item['points']);
      _completedWorkouts.add(cw);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['completedWorkouts'] = _completedWorkouts.map((i) => i.toJson()).toList();

    return map;
  }

  void addCompletedWorkout(CompletedWorkout cw) {
    _completedWorkouts.add(cw);
  }

  List<CompletedWorkout> getCompletedWorkouts() {
    return _completedWorkouts;
  }

  List<CompletedWorkout> thisWeeksCompletedWorkouts() {
    List<CompletedWorkout> completedWorkouts = [];
    for (CompletedWorkout cw in _completedWorkouts) {
      if (cw.isThisWeek()) {
        completedWorkouts.add(cw);
      }
    }
    return completedWorkouts;
  }

  int getPumpPointsThisWeek() {
    int result = 0;
    for (CompletedWorkout cw in thisWeeksCompletedWorkouts()) {
      result += cw.getPumpPoints();
    }
    return result;
  }

  List<int> getPumpPointsThisWeekArr() {
    List<int> result = [0, 0, 0, 0, 0, 0, 0];
    for (int i = 1; i < 8; i++) {
      for (CompletedWorkout cw in thisWeeksCompletedWorkouts()) {
        if (cw
            .getDate()
            .weekday == i) {
          if (i == 7) {
            result[0] += cw.getPumpPoints();
          } else {
            result[i] += cw.getPumpPoints();
          }
        }
      }
    }
    return result;
  }
}

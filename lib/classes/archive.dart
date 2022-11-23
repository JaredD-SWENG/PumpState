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
}

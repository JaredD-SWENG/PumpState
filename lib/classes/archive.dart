import 'completedWorkout.dart';

/// Archive holds the user's completed workouts
class Archive {
  List<CompletedWorkout> _completedWorkouts = [];

  /// Default constructor
  Archive();

  /// Constructor to generate Object from JSON
  Archive.fromJson(Map<String, dynamic> map) {
    for (dynamic item in map['completedWorkouts']) {
      CompletedWorkout cw = CompletedWorkout(item['date'], item['points']);
      _completedWorkouts.add(cw);
    }
  }

  /// Generates a JSON string of Archive
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['completedWorkouts'] = _completedWorkouts.map((i) => i.toJson()).toList();
    return map;
  }

  /// Adds a singular completed workout to the Archive of completed workouts
  void addCompletedWorkout(CompletedWorkout cw) {
    _completedWorkouts.add(cw);
  }

  /// Returns a list of completed workouts from the Archive
  List<CompletedWorkout> getCompletedWorkouts() {
    return _completedWorkouts;
  }

  /// Returns a list of completed workouts that occured this week from Archive
  List<CompletedWorkout> thisWeeksCompletedWorkouts() {
    List<CompletedWorkout> completedWorkouts = [];
    for (CompletedWorkout cw in _completedWorkouts) {
      if (cw.isThisWeek()) {
        completedWorkouts.add(cw);
      }
    }
    return completedWorkouts;
  }

  /// Returns the count of pump points for this week
  int getPumpPointsThisWeek() {
    int result = 0;
    for (CompletedWorkout cw in thisWeeksCompletedWorkouts()) {
      result += cw.getPumpPoints();
    }
    return result;
  }

  /// Returns a list of pump points for the seven days of the week where [0] is Monday
  List<int> getPumpPointsThisWeekArr() {
    List<int> result = [0, 0, 0, 0, 0, 0, 0];
    // Must start at 1 according to ISO 8601
    for (int i = 1; i < 8; i++) {
      for (CompletedWorkout cw in thisWeeksCompletedWorkouts()) {
        if (cw.getDate().weekday == i) {
          // Moves 7 (sunday) to position 0
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

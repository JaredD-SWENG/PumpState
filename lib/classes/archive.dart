import 'package:uuid/uuid.dart';
import 'workout.dart';
import 'completedWorkout.dart';

class Archive {
  List<CompletedWorkout> _completedWorkouts = [];

  Archive();

  Archive.fromJson(List<dynamic> d) {
    for (dynamic item in d) {
      CompletedWorkout cw = CompletedWorkout(item['date'], item['points']);
      _completedWorkouts.add(cw);
    }
  }

  void addCompletedWorkout(CompletedWorkout cw) {
    _completedWorkouts.add(cw);
  }

  List<CompletedWorkout> getCompletedWorkouts() {
    return _completedWorkouts;
  }
}

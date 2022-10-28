import 'package:pump_state/classes/scheduledWorkout.dart';
import 'workout.dart';

class Scheduler {
  List<ScheduledWorkout> _scheduledWorkout =
      []; //Object to store Date / Workout to be stored.

  Scheduler();

  Scheduler.fromJson(Map<String, dynamic> map) {
    for (dynamic item in map['scheduledWorkouts']) {
      ScheduledWorkout sw = ScheduledWorkout(
          item['scheduledDate'], Workout.fromJSON(item['scheduledWorkout']));
      _scheduledWorkout.add(sw);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map();
    map['scheduledWorkouts'] =
        _scheduledWorkout.map((i) => i.toJson()).toList();
    return map;
  }

  //Idea ATM is to pull saved Scheduled workouts fromJSON, and then after doing so perform a function called "check dates"
  //Which will delete any scheduled workouts that are old. (I.E. scheduled workouts that are past their date)

  //Purpose of this method is to be called after reading fromJSON. Used to clear out any old schedueld workouts.
  void checkDates() {
    DateTime today = DateTime.now(); //Todays Date
    for (int i = 0; i < _scheduledWorkout.length; i++) {
      //for every object stored in schedule, check
      DateTime temp = _scheduledWorkout[i].getDate();

      if (temp.year < today.year) {
        //Previous year, remove scheduled workout.
        _scheduledWorkout.removeAt(i);
        i--;
      } else if (temp.year == today.year && temp.month < today.month) {
        // Same year, prev month, remove scheduled workout.
        _scheduledWorkout.removeAt(i);
        i--;
      } else if (temp.month == today.month && temp.day < today.day) {
        //Same month, previous day, remove scheduled workout.
        _scheduledWorkout.removeAt(i);
        i--;
      }
    }
  }

  void printScheduledWorkouts() {
    for (ScheduledWorkout s in _scheduledWorkout) {
      print(s.scheduledWorkout.getName());
    }
  }
}

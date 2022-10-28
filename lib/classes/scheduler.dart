import 'package:pump_state/classes/scheduledWorkout.dart';

class Scheduler {
  late List<ScheduledWorkout>
      schedule; //Object to store Date / Workout to be stored.
  late DateTime today; //Todays date, checked on App Startup.
  Scheduler();

  //Idea ATM is to pull saved Scheduled workouts fromJSON, and then after doing so perform a function called "check dates"
  //Which will delete any scheduled workouts that are old. (I.E. scheduled workouts that are past their date)

  //Purpose of this method is to be called after reading fromJSON. Used to clear out any old schedueld workouts.
  void checkDates() {
    today = DateTime.now(); //Todays Date

    for (dynamic d in schedule) {
      //for every object stored in schedule, check.

      DateTime temp = schedule[d].getDate();

      if (temp.year < today.year) {
        //Previous year, remove scheduled workout.
        schedule.removeAt(d);
      } else if (temp.year == today.year && temp.month < today.month) {
        // Same year, prev month, remove scheduled workout.
        schedule.removeAt(d);
      } else if (temp.month == today.month && temp.day < today.day) {
        //Same month, previous day, remove scheduled workout.
        schedule.removeAt(d);
      }
    }
  }
}

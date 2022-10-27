import 'package:pump_state/classes/workout.dart';

class ScheduledWorkout {

  late DateTime scheduledDate;
  late Workout scheduledWorkout;

  ScheduledWorkout();

  getDate() {
    return scheduledDate;
  }

  getWorkout(){return ScheduledWorkout;}
}

import 'package:pump_state/classes/workout.dart';
import 'package:uuid/uuid.dart';

class ScheduledWorkout {
  late DateTime scheduledDate;
  late Workout scheduledWorkout;

  ScheduledWorkout(String d, Workout w) {
    scheduledDate = DateTime.parse(d);
    scheduledWorkout = w;
  }

  getDate() {
    return scheduledDate;
  }

  getWorkout() {
    return ScheduledWorkout;
  }

  Map<String, dynamic> toJson() => {
        'scheduledDate': scheduledDate.toString(),
        'scheduledWorkout': scheduledWorkout.toJson()
      };
}

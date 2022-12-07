import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../classes/workout.dart';

///workoutProvider is a State Provider used when the user wishes to edit or create a new workout.
///this provider hosts an instance of workout that, whenever altered, willchange the output and implementation of the UI
final workoutProvider = StateProvider<Workout>((ref) {
  return Workout();
});

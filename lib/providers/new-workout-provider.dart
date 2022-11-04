import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../classes/workout.dart';

final newWorkoutProvider = StateProvider<Workout>((ref) {
  return Workout();
});

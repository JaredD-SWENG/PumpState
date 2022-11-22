import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../classes/workout.dart';

final workoutProvider = StateProvider<Workout>((ref) {
  return Workout();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../classes/workout.dart';

///playWorkoutProvider is a State Provider used when the User decides to play a workout.
///This provider hosts an instance of the user chosen workout to be played, any alterations
///or usages of this provider changes logic implementation and output of the UI.
final playWorkoutProvider = StateProvider<Workout>((ref) {
  return Workout();
});

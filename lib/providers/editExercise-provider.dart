import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../classes/exercise.dart';

final editExerciseProvider = StateProvider<Exercise>((ref) {
  return Exercise();
});

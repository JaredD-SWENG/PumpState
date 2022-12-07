import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../classes/exercise.dart';

///exerciseProvider is a State provider used by Pump State to host an instance of Exercise,
///this provider is used whenever the user wishes to create or edit a workout. Any changes
///made to the instance of exercise stored in this proivder alters UI logic and output to the user.
final exerciseProvider = StateProvider<Exercise>((ref) {
  return Exercise();
});

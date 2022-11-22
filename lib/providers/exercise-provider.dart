import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../classes/exercise.dart';

final exerciseProvider = StateProvider<Exercise>((ref) {
  return Exercise();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../classes/workout.dart';

///pumpPointsProvider is a State Provider which holds an int instance, this int value is used to store
///the pump points earned per completed exercise during the play workout functions.
final pumpPointsProver = StateProvider<int>((ref) {
  return 0;
});

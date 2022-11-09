import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/new-workout-provider.dart';

import '../classes/config.dart';

class SaveWorkoutButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Config c = Config.newState(ref.read(configProvider).library, ref.read(configProvider).archive, ref.read(configProvider).scheduler);
          c.library.addWorkout(ref.read(newWorkoutProvider));
          ref.read(configProvider.notifier).state = c;
        },
        child: Text('Save Workout'),
      ),
    );
  }
}

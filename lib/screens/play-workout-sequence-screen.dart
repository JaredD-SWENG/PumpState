import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/play-workout-provider.dart';
import 'package:pump_state/styles/styles.dart';

import '../classes/activity.dart';

class PlayWorkoutSequenceScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<PlayWorkoutSequenceScreen> createState() => _PlayWorkoutSequenceScreenState();
}

class _PlayWorkoutSequenceScreenState extends ConsumerState<PlayWorkoutSequenceScreen> {
  late Activity currentActivity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentActivity = ref.read(playWorkoutProvider).getActivityList()[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: linearGradient(),
      child: Center(
        child: Text('this is a placeholder'),
      ),
    );
  }
}

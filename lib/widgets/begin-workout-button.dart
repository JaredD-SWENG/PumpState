import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/widgets/error-card.dart';

import '../providers/play-workout-provider.dart';

///BeginWorkoutButton is a Widget called by play-screen.dart, this Widget generates an interactable button that
///when pressed pushes a  play-workout-sequence-screen instace that begins the workout.
class BeginWorkoutButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/play-workout');
            },
            child: Text('Begin Workout')));
  }
}

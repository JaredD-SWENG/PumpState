import 'package:flutter/material.dart';

///BeginWorkoutButton is a Widget called by play-screen.dart, this Widget generates an interactable button that
///when pressed pushes a  play-workout-sequence-screen instace that begins the workout.
class BeginWorkoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/play-workout');
            },
            child: Text('Begin Workout')));
  }
}

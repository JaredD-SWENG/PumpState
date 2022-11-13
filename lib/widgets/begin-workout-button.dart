import 'package:flutter/material.dart';

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

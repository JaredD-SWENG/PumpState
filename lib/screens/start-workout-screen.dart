import 'package:flutter/material.dart';

class StartWorkoutScreen extends StatelessWidget {
  const StartWorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Workout'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => {Navigator.pop(context)},
          child: Text('Go to Home'),
        ),
      ),
    );
  }
}

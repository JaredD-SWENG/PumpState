import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final Function changeScreen;

  const ErrorCard({Key? key, required this.changeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('No workouts available'),
      backgroundColor: Color.fromRGBO(48, 47, 47, 1.0),
      content: const Text('Before playing a workout please create one', style: TextStyle(color: Colors.red, fontSize: 20.00)),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () => changeScreen(4),
          child: Text('Create Workout'),
        )
      ],
    );
  }
}

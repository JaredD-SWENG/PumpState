import 'package:flutter/material.dart';

class LibraryWorkoutScreen extends StatelessWidget {
  const LibraryWorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library/Workouts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new-workout');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

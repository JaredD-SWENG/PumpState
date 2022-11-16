import 'package:flutter/material.dart';

import '../classes/activity.dart';
import '../classes/exercise.dart';

class PlayExercise extends StatefulWidget {
  final Activity a;
  final int setNumber;

  const PlayExercise({Key? key, required this.a, required this.setNumber}) : super(key: key);

  @override
  State<PlayExercise> createState() => _PlayExerciseState();
}

class _PlayExerciseState extends State<PlayExercise> {
  late Exercise e;
  late int reps;
  late int sets;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    e = widget.a as Exercise;
    reps = e.getReps();
    sets = widget.setNumber;
  }

  void incrementReps() {
    setState(() {
      reps++;
    });
  }

  void decrementReps() {
    setState(() {
      if (reps == 0) return;
      reps--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('Set Number: ${widget.setNumber}'),
            Text('Complete 1 set of ${e.getReps()} reps'),
            Text('How many actual reps were completed?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(reps.toString()),
                ElevatedButton(onPressed: incrementReps, child: const Text("Add Rep")),
                ElevatedButton(onPressed: decrementReps, child: const Text("Remove Rep")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

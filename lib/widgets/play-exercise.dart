import 'package:flutter/material.dart';

import '../classes/activity.dart';
import '../classes/exercise.dart';
import '../styles/styles.dart';

/// Plays a exercise sequence from PlayWorkoutSequenceScreen
class PlayExercise extends StatefulWidget {
  final Activity a;
  final int setNumber;
  final int setCountInExercise;
  final Function setReps;

  const PlayExercise({
    Key? key,
    required this.a,
    required this.setNumber,
    required this.setCountInExercise,
    required this.setReps,
  }) : super(key: key);

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
    reps = e.getReps(); // Set the expected reps for the workout
    sets = widget.setNumber; // Set the sets for the workout
    widget.setReps(reps); // Set the actual reps for the workout
  }

  /// Increments the actual reps completed
  void incrementReps() {
    setState(() {
      reps++;
      widget.setReps(reps);
    });
  }

  /// Decrements the actual reps completed
  void decrementReps() {
    setState(() {
      if (reps == 0) return;
      reps--;
      widget.setReps(reps);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * .4, 10, MediaQuery.of(context).size.width * .4, 10),
          child: Container(
            decoration: BoxDecoration(boxShadow: [cardBoxShadow()]),
            child: Card(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: [
                              Text(
                                'Set',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                '${widget.setNumber} / ${widget.setCountInExercise}',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ))),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: [
                              Text(
                                'Reps',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                '${e.getReps()}',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ))),
                ],
              ),
            ),
          )),
      Card(
        child: Column(
          children: [
            Text(
              'Reps Completed',
              style: Theme.of(context).textTheme.headline5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(reps.toString(), style: Theme.of(context).textTheme.headline5),
                ElevatedButton(onPressed: incrementReps, child: const Text("Add Rep")),
                ElevatedButton(onPressed: decrementReps, child: const Text("Remove Rep")),
              ],
            )
          ],
        ),
      )
    ]);
  }
}

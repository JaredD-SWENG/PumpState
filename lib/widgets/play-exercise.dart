import 'package:flutter/material.dart';

import '../classes/activity.dart';
import '../classes/exercise.dart';
import '../styles/styles.dart';

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
          child: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(160, 10, 160, 10),
          child: Card(
            color: whiteOut(),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Column(
                          children: [
                            Text(
                              'Set',
                              style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 18.0, color: limestone()),
                            ),
                            Text(
                              '${widget.setNumber}',
                              style: TextStyle(fontFamily: 'Roboto', fontSize: 18.0, color: beaverBlue()),
                            ),
                          ],
                        ))),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Column(
                          children: [
                            Text(
                              'Reps',
                              style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 18.0, color: limestone()),
                            ),
                            Text(
                              '${reps}',
                              style: TextStyle(fontFamily: 'Roboto', fontSize: 18.0, color: beaverBlue()),
                            ),
                          ],
                        ))),
              ],
            ),
          ),
        ),
        Card(
          child: Column(
            children: [
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
        )
      ])),
    );
  }
}

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
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: [
                              Text(
                                'Set',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(
                                '${widget.setNumber}',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ))),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: [
                              Text(
                                'Reps',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(
                                '${reps}',
                                style: Theme.of(context).textTheme.headline5,
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

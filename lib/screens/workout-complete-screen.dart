import 'package:flutter/material.dart';

///WorkoutCompleteScreen is a screen called at the end of play-workout-sequence-screen, when the Workout has been exhausted.
///This widget outputs to the user the number of PumpPoints earned in the completed workout.
class WorkoutCompleteScreen extends StatelessWidget {
  final double pumpPoints;

  const WorkoutCompleteScreen({Key? key, required this.pumpPoints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///build function returns a widget to display to the user how many pump points have been earned from completing this workout.
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * .5,
          child: Card(
            child: Column(
              children: [
                Text(
                  'You earned',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${pumpPoints.toStringAsFixed(0)} Pump Points',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Finish'))
      ],
    );
  }
}

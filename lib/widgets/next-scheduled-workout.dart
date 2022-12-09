import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';

import '../classes/scheduledWorkout.dart';
import '../styles/styles.dart';

/// Analytics component that displays the next scheduled workout on the home screen
class NextScheduledWorkout extends ConsumerWidget {
  const NextScheduledWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Generates a widget that display either "None" or the name of the next scheduled workout.
    Widget generateNoneOrNSW() {
      // If there are no scheduled workouts, return "None" widget
      if (ref.read(configProvider).scheduler.getSchedule().isEmpty) {
        return Column(
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                  "Next Scheduled Workout",
                  style: Theme.of(context).textTheme.headline5,
                )
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'None',
                    style: TextStyle(color: creek(), fontSize: 60),
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        // Return next scheduled workout widget
        ScheduledWorkout sw = ref.read(configProvider).scheduler.nextScheduledWorkout();
        return Column(
          children: [
            Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Next Scheduled Workout",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      sw.getName(),
                      style: TextStyle(
                        color: creek(),
                        fontSize: 60,
                      ),
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    sw.getFormattedDate(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )),
          ],
        );
      }
    }

    ;

    return Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * .19,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: nittanyNavy(),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: generateNoneOrNSW());
  }
}

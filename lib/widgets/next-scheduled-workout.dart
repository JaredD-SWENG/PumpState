import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/classes/scheduledWorkout.dart';
import 'package:pump_state/providers/config-provider.dart';

import '../classes/completedWorkout.dart';
import '../styles/styles.dart';

class NextScheduledWorkout extends ConsumerWidget {
  const NextScheduledWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget test() {
      if (ref.read(configProvider).scheduler.getSchedule().length == 0) {
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Next Scheduled Workout",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'None',
                style: TextStyle(
                  color: creek(),
                  fontSize: 60,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "This Week",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        );
      } else {
        ScheduledWorkout sw = ref.read(configProvider).scheduler.nextScheduledWorkout();
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Next Scheduled Workout",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sw.getName(),
                style: TextStyle(
                  color: creek(),
                  fontSize: 60,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "This Week",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        );
      }
    }

    ;

    return Container(
        width: MediaQuery.of(context).size.width * 0.50,
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
        child: test());
  }
}

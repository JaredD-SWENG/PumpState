import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/play-workout-provider.dart';
import '../classes/activity.dart';
import '../classes/break.dart';
import '../classes/exercise.dart';
import '../widgets/play-break.dart';
import '../widgets/play-exercise.dart';
import '../widgets/play-pause.dart';

class PlayWorkoutSequenceScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<PlayWorkoutSequenceScreen> createState() => _PlayWorkoutSequenceScreenState();
}

class _PlayWorkoutSequenceScreenState extends ConsumerState<PlayWorkoutSequenceScreen> {
  late final activityCount;
  late Activity currentActivity;
  late int currentSetCount;
  int currentActivityIndex = 0;
  int screenIndex = 0;
  late List<Widget> screens = <Widget>[
    PlayExercise(
      a: currentActivity,
      setNumber: currentSetCount,
    ),
    PlayBreak(
      changeScreen: changeScreenFromBreak,
    ),
    PlayPause(
      a: currentActivity,
      changeScreen: changeScreenFromPause,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activityCount = ref.read(playWorkoutProvider).getSizeOfActivityList() - 1;
    currentActivity = ref.read(playWorkoutProvider).getActivityList()[0];
    currentSetCount = 1;
    if (currentActivity is Exercise) {
      screenIndex = 0;
    } else {
      screenIndex = 2;
    }
  }

  handleContinue() {
    setState(() {
      /*
      The continue button is only applicable on a set within an exercise. There are only two paths from here
      -- another exercise or a pause
       */
      Exercise e = currentActivity as Exercise;
      if (currentSetCount < e.getSets()) {
        // If hitting continue and there are more sets to complete
        currentSetCount++;
        // Rebuild state of play exercise
        screens[0] = PlayExercise(
          a: currentActivity,
          setNumber: currentSetCount,
        );
        screenIndex = 1;
      } else {
        // If hitting continue on final set
        if (currentActivityIndex < activityCount) {
          // Check to see if there are more activities
          Activity nextActivity = ref.read(playWorkoutProvider).getActivity(currentActivityIndex + 1);
          if (nextActivity is Exercise) {
            currentActivityIndex++;
            currentActivity = nextActivity;
            currentSetCount = 1;
            screens[0] = PlayExercise(
              a: currentActivity,
              setNumber: currentSetCount,
            );
            screenIndex = 0;
          }
          if (nextActivity is Break) {
            currentActivityIndex++;
            currentActivity = nextActivity;
            currentSetCount = 1;
            screens[2] = PlayPause(a: nextActivity, changeScreen: changeScreenFromPause);
            screenIndex = 2;
          }
        }
      }
    });
  }

  changeScreenFromBreak() {
    setState(() {
      screenIndex = 0;
    });
  }

  changeScreenFromPause() {
    setState(() {
      print("currentActivityIndex = $currentActivityIndex");
      print("activityCount = $activityCount");

      if (currentActivityIndex < activityCount) {
        Activity nextActivity = ref.read(playWorkoutProvider).getActivity(currentActivityIndex + 1);
        if (nextActivity is Exercise) {
          currentActivityIndex++;
          currentActivity = nextActivity;
          screens[0] = PlayExercise(
            a: currentActivity,
            setNumber: currentSetCount,
          );
          screenIndex = 0;
        }
        if (nextActivity is Break) {
          currentActivityIndex++;
          currentActivity = nextActivity;
          screens[2] = new PlayPause(key: UniqueKey(), a: nextActivity, changeScreen: changeScreenFromPause);
          screenIndex = 2;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Index: ${currentActivityIndex} ${currentActivity.getName()}'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          screens[screenIndex],
          IconButton(
              onPressed: () {
                handleContinue();
              },
              icon: const Icon(Icons.arrow_circle_right))
        ],
      )),
    );
  }
}

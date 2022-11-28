import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/classes/completedWorkout.dart';
import 'package:pump_state/classes/file-io.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/providers/play-workout-provider.dart';
import 'package:pump_state/screens/workout-complete-screen.dart';
import 'package:pump_state/styles/styles.dart';
import '../classes/activity.dart';
import '../classes/break.dart';
import '../classes/config.dart';
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
  int setsInExercise = 0;
  int currentActivityIndex = 0;
  int screenIndex = 0;
  double pumpPoints = 0;
  int actualReps = 0;
  late List<Widget> screens = <Widget>[
    PlayExercise(
      a: currentActivity,
      setNumber: currentSetCount,
      setCountInExercise: setsInExercise,
      setReps: setReps,
    ),
    PlayBreak(
      changeScreen: changeScreenFromBreak,
    ),
    PlayPause(
      a: currentActivity,
      changeScreen: changeScreenFromPause,
    ),
    WorkoutCompleteScreen(pumpPoints: pumpPoints),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activityCount = ref.read(playWorkoutProvider).getSizeOfActivityList() - 1;
    currentActivity = ref.read(playWorkoutProvider).getActivityList()[0];
    currentSetCount = 1;
    if (currentActivity is Exercise) {
      Exercise e = currentActivity as Exercise;
      setsInExercise = e.getSets();
      screenIndex = 0;
    } else {
      screenIndex = 2;
    }
  }

  void setReps(int i) {
    actualReps = i;
  }

  void archiveWorkout() {
    CompletedWorkout cw = CompletedWorkout.createNew(DateTime.now(), pumpPoints.toInt());
    Config c = ref.read(configProvider);
    c.archive.addCompletedWorkout(cw);
    ref.read(configProvider.notifier).state = c;
    FileIO.writeConfig(ref.read(configProvider));
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
        // Calculate Pump Points
        // Rebuild state of play exercise
        screens[0] = PlayExercise(
          a: currentActivity,
          setNumber: currentSetCount,
          setCountInExercise: setsInExercise,
          setReps: setReps,
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
              setCountInExercise: e.getSets(),
              setReps: setReps,
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
        } else {
          archiveWorkout();
          screens[3] = WorkoutCompleteScreen(pumpPoints: pumpPoints);
          screenIndex = 3;
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
      if (currentActivityIndex < activityCount) {
        Activity nextActivity = ref.read(playWorkoutProvider).getActivity(currentActivityIndex + 1);
        if (nextActivity is Exercise) {
          currentActivityIndex++;
          currentActivity = nextActivity;
          screens[0] = PlayExercise(
            a: currentActivity,
            setNumber: currentSetCount,
            setCountInExercise: setsInExercise,
            setReps: setReps,
          );
          screenIndex = 0;
        }
        if (nextActivity is Break) {
          currentActivityIndex++;
          currentActivity = nextActivity;
          screens[2] = PlayPause(
            key: UniqueKey(),
            a: nextActivity,
            changeScreen: changeScreenFromPause,
          );
          screenIndex = 2;
        }
      } else {
        archiveWorkout();
        screens[3] = WorkoutCompleteScreen(pumpPoints: pumpPoints);
        screenIndex = 3;
      }
    });
  }

  void addPumpPoints() {
    Exercise e = currentActivity as Exercise;
    if (actualReps > e.getReps()) {
      pumpPoints += (actualReps * 1.25) * 1000;
    } else if (actualReps == e.getReps()) {
      pumpPoints += (actualReps * 1000);
    } else {
      pumpPoints += (actualReps * 0.75) * 1000;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentActivity.getName()),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          decoration: BoxDecoration(gradient: backgroundGradient()),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: screens[screenIndex],
              ),
              if (screenIndex == 0)
                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          addPumpPoints();
                          handleContinue();
                          if (currentActivityIndex < activityCount) {
                            actualReps = 0;
                          }
                        },
                        icon: const Icon(Icons.arrow_circle_right)))
            ],
          )),
    );
  }
}

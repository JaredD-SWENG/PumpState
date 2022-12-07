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

/// Plays in sequence the configured workout looping until the end
/// and prompting user input where necessary
class PlayWorkoutSequenceScreen extends ConsumerStatefulWidget {
  const PlayWorkoutSequenceScreen({super.key});

  @override
  ConsumerState<PlayWorkoutSequenceScreen> createState() => _PlayWorkoutSequenceScreenState();
}

class _PlayWorkoutSequenceScreenState extends ConsumerState<PlayWorkoutSequenceScreen> {
  late final activityCount; // Number of activities in workout
  late Activity currentActivity; // Current activity being played
  late int currentSetCount; // What set the user is currently on
  int setsInExercise = 0; // Total number of sets in a the current exercise
  int currentActivityIndex = 0; // Current activity index
  int screenIndex = 0; // What screen is currently being displayed
  double pumpPoints = 0; // Pump points calculated for a given set
  int actualReps = 0; // Actual reps completed, used to compare against expected
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
    activityCount = ref.read(playWorkoutProvider).getSizeOfActivityList() - 1; // Sets the number of activities in the workout
    currentActivity = ref.read(playWorkoutProvider).getActivityList()[0]; // Sets the current activity to the first in the list
    currentSetCount = 1; // Initializes current set count to 1
    // If the current activity is an exericse, move to the exercise screen, else move to the pause screen
    if (currentActivity is Exercise) {
      Exercise e = currentActivity as Exercise;
      setsInExercise = e.getSets();
      screenIndex = 0;
    } else {
      screenIndex = 2;
    }
  }

  /// Sets the actual reps to integer i
  void setReps(int i) {
    actualReps = i;
  }

  /// Archives the workout when completed
  void archiveWorkout() {
    CompletedWorkout cw = CompletedWorkout.createNew(DateTime.now(), pumpPoints.toInt()); // Creates a new completed workout
    Config c = ref.read(configProvider); // Reads current state of config
    c.archive.addCompletedWorkout(cw); // Adds completed workout to archive
    ref.read(configProvider.notifier).state = c; // Sets the state with the completed workout added
    FileIO.writeConfig(ref.read(configProvider)); // Overwrites the local store with new config file
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

  /// Function to be based to break screen to change the screen of parent widget
  changeScreenFromBreak() {
    setState(() {
      screenIndex = 0;
    });
  }

  /// Function to be based to pause screen to change the screen of parent widget
  changeScreenFromPause() {
    setState(() {
      // If there are more activities in the list
      if (currentActivityIndex < activityCount) {
        // Get the next activity
        Activity nextActivity = ref.read(playWorkoutProvider).getActivity(currentActivityIndex + 1);
        // If that activity is an Exercise
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
        // If that activity is a Break
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
        archiveWorkout(); // Archive the workout if the final set
        screens[3] = WorkoutCompleteScreen(pumpPoints: pumpPoints); // Create a completed screen with pump points
        screenIndex = 3; // Change to completed workout screen
      }
    });
  }

  /// Formula for calculating pump points
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

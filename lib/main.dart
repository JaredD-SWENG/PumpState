import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/screens/edit-exercise-screen.dart';
import 'package:pump_state/screens/home-screen.dart';
import 'package:pump_state/screens/library-activities-screen.dart';
import 'package:pump_state/screens/library-workouts-screen.dart';
import 'package:pump_state/screens/main-screen.dart';
import 'package:pump_state/screens/new-exercise-screen.dart';
import 'package:pump_state/screens/new-workout-screen.dart';
import 'package:pump_state/screens/play-workout-sequence-screen.dart';
import 'package:pump_state/screens/start-workout-screen.dart';
import 'package:pump_state/styles/global-theme.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/edit-exercise-form.dart';
import 'classes/file-io.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FileIO.initConfig(ref);

    return MaterialApp(
        home: MainScreen(),
        routes: {
          '/new-exercise': (context) => NewExerciseScreen(),
          '/new-workout': (context) => NewWorkoutScreen(),
          '/play-workout': (context) => PlayWorkoutSequenceScreen(),
        },
        theme: globalTheme());
  }
}

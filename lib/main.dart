import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/screens/main-screen.dart';
import 'package:pump_state/screens/new-exercise-screen.dart';
import 'package:pump_state/screens/new-workout-screen.dart';
import 'package:pump_state/screens/play-workout-sequence-screen.dart';
import 'package:pump_state/styles/global-theme.dart';
import 'classes/file-io.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    try {
      FileIO.initConfig(ref);
    } catch (e) {
      return MaterialApp(
        home: Scaffold(
          body: Container(
            child: AlertDialog(
              title: Text("App failed to load"),
              content: Text('Data is corrupted. Please uninstall and reinstall the application. Error: $e'),
            ),
          ),
        ),
      );
    }
    return MaterialApp(
        home: const MainScreen(),
        routes: {
          '/new-exercise': (context) => const NewExerciseScreen(),
          '/new-workout': (context) => NewWorkoutScreen(),
          '/play-workout': (context) => const PlayWorkoutSequenceScreen(),
        },
        theme: globalTheme());
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/screens/edit-exercise-screen.dart';
import 'package:pump_state/screens/home-screen.dart';
import 'package:pump_state/screens/library-activities-screen.dart';
import 'package:pump_state/screens/library-screen.dart';
import 'package:pump_state/screens/library-workouts-screen.dart';
import 'package:pump_state/screens/new-exercise-screen.dart';
import 'package:pump_state/screens/start-workout-screen.dart';
import 'package:pump_state/widgets/edit-exercise-form.dart';
import 'classes/file-io.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // const jsonBlob =
    //     "{\"library\":{\"workouts\":[{\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"},{\"id\":\"asdfkjnb23\",\"duration\":\"1000\"},{\"id\":\"testId2\",\"name\":\"testName2\",\"sets\":\"3\",\"reps\":\"3000\",\"favorite\":\"true\"}],\"name\":\"Test1\",\"id\":\"1234\",\"favorite\":\"true\"},{\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"},{\"id\":\"thisisabreak\",\"duration\":\"2000\"},{\"id\":\"testId2\",\"name\":\"testName2\",\"sets\":\"3\",\"reps\":\"3000\",\"favorite\":\"true\"}],\"name\":\"Test12\",\"id\":\"123456\",\"favorite\":\"false\"}],\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"}]},\"archive\":{\"completedWorkouts\":[{\"date\":\"2022-10-22 00:00:00.000\",\"points\":\"12342435235\"},{\"date\":\"2022-10-22 00:00:00.000\",\"points\":\"123424352356\"},{\"date\":\"2022-10-22 00:00:00.000\",\"points\":\"123424352357\"}]},\"scheduler\":{\"scheduledWorkouts\":[{\"scheduledDate\":\"2022-10-22 00:00:00.000\",\"scheduledWorkout\":{\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"},{\"id\":\"asdfkjnb23\",\"duration\":\"1000\"},{\"id\":\"testId2\",\"name\":\"testName2\",\"sets\":\"3\",\"reps\":\"3000\",\"favorite\":\"true\"}],\"name\":\"Test1\",\"id\":\"1234\",\"favorite\":\"true\"}},{\"scheduledDate\":\"2021-10-27 12:00:00.000\",\"scheduledWorkout\":{\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"},{\"id\":\"asdfkjnb23\",\"duration\":\"1000\"},{\"id\":\"testId2\",\"name\":\"testName2\",\"sets\":\"3\",\"reps\":\"3000\",\"favorite\":\"true\"}],\"name\":\"Test2\",\"id\":\"1234\",\"favorite\":\"true\"}}]}}";
    // var decodedJsonMap = jsonDecode(jsonBlob);
    // Config c = Config.fromJson(decodedJsonMap);
    // Map<String, dynamic> map = c.toJson();
    // String s = jsonEncode(map);
    //print(s);
    FileIO.initConfig(ref);

    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => HomeScreen(),
      '/library': (context) => LibraryScreen(),
      '/start': (context) => StartWorkoutScreen(),
      '/library/activities': (context) => LibraryActivitiesScreen(),
      '/new-exercise': (context) => NewExerciseScreen(),
      '/library/workouts': (context) => LibraryWorkoutScreen(),
      '/edit-exericse': (context) => EditExerciseScreen(),
    });
  }
}

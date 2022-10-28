import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pump_state/classes/config.dart';
import 'package:path_provider/path_provider.dart';

import 'classes/activity.dart';
import 'classes/exercise.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const jsonBlob =
    //     "{\"library\":{\"workouts\":[{\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"},{\"id\":\"asdfkjnb23\",\"duration\":\"1000\"},{\"id\":\"testId2\",\"name\":\"testName2\",\"sets\":\"3\",\"reps\":\"3000\",\"favorite\":\"true\"}],\"name\":\"Test1\",\"id\":\"1234\",\"favorite\":\"true\"},{\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"},{\"id\":\"thisisabreak\",\"duration\":\"2000\"},{\"id\":\"testId2\",\"name\":\"testName2\",\"sets\":\"3\",\"reps\":\"3000\",\"favorite\":\"true\"}],\"name\":\"Test12\",\"id\":\"123456\",\"favorite\":\"false\"}],\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"}]},\"archive\":{\"completedWorkouts\":[{\"date\":\"2022-10-22 00:00:00.000\",\"points\":\"12342435235\"},{\"date\":\"2022-10-22 00:00:00.000\",\"points\":\"123424352356\"},{\"date\":\"2022-10-22 00:00:00.000\",\"points\":\"123424352357\"}]},\"scheduler\":{\"scheduledWorkouts\":[{\"scheduledDate\":\"2022-10-22 00:00:00.000\",\"scheduledWorkout\":{\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"},{\"id\":\"asdfkjnb23\",\"duration\":\"1000\"},{\"id\":\"testId2\",\"name\":\"testName2\",\"sets\":\"3\",\"reps\":\"3000\",\"favorite\":\"true\"}],\"name\":\"Test1\",\"id\":\"1234\",\"favorite\":\"true\"}},{\"scheduledDate\":\"2021-10-27 12:00:00.000\",\"scheduledWorkout\":{\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"},{\"id\":\"asdfkjnb23\",\"duration\":\"1000\"},{\"id\":\"testId2\",\"name\":\"testName2\",\"sets\":\"3\",\"reps\":\"3000\",\"favorite\":\"true\"}],\"name\":\"Test2\",\"id\":\"1234\",\"favorite\":\"true\"}}]}}";
    // var decodedJsonMap = jsonDecode(jsonBlob);
    // Config c = Config.fromJson(decodedJsonMap);
    // Map<String, dynamic> map = c.toJson();
    // String s = jsonEncode(map);
    //print(s);
    initConfig();

    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => InitApp(),
    });
  }
}

class InitApp extends StatefulWidget {
  const InitApp({Key? key}) : super(key: key);

  @override
  State<InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  Config _config = Config();

  List<ElevatedButton> generateActivities() {
    List<ElevatedButton> listOfButtons = [];
    for (Activity a in _config.library.getlistofactivities()) {
      ElevatedButton eb =
      ElevatedButton(onPressed: () {}, child: Text(a.getName()));
      listOfButtons.add(eb);
    }
    return listOfButtons;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readConfig().then((Config c) {
      setState(() {
        _config = c;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:

        generateActivities(),
      ),
    );
  }
}

Future<void> initConfig() async {
  Directory dir = await getApplicationDocumentsDirectory();
  String filePath = "${dir.path}/config.json";

  // if file does not exist
  if (!File(filePath).existsSync()) {
    Config c = Config();
    Map<String, dynamic> initConfig = c.toJson(); //Generate empty JSON
    String initS = jsonEncode(initConfig);
    File file = File(filePath);
    file.writeAsStringSync(initS);
  }
}

Future<Config> readConfig() async {
  Directory dir = await getApplicationDocumentsDirectory();
  String filePath = "${dir.path}/config.json";

  File file = File(filePath);
  String readS = file.readAsStringSync();
  print(readS);
  Map<String, dynamic> readMap = jsonDecode(readS);

  Config c = Config.fromJson(readMap);
  return c;
}

Future<void> writeConfig(Config c) async {
  Directory dir = await getApplicationDocumentsDirectory();
  String filePath = "${dir.path}/config.json";

  Map<String, dynamic> writeMap = c.toJson();
  String writeS = jsonEncode(writeMap);

  File file = File(filePath);
  file.writeAsStringSync(writeS);
}

Future<void> printActivity() async {}

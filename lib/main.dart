import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pump_state/classes/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const jsonBlob =
        "{\"library\":{\"workouts\":[{\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"},{\"id\":\"asdfkjnb23\",\"duration\":\"1000\"},{\"id\":\"testId2\",\"name\":\"testName2\",\"sets\":\"3\",\"reps\":\"3000\",\"favorite\":\"true\"}],\"id\":\"1234\",\"name\":\"Test1\",\"favorite\":\"true\"},{\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"},{\"id\":\"thisisabreak\",\"duration\":\"2000\"},{\"id\":\"testId2\",\"name\":\"testName2\",\"sets\":\"3\",\"reps\":\"3000\",\"favorite\":\"true\"}],\"id\":\"123456\",\"name\":\"Test12\",\"favorite\":\"false\"}],\"activities\":[{\"id\":\"testId0\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId1\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"},{\"id\":\"testId2\",\"name\":\"testName0\",\"sets\":\"1\",\"reps\":\"1000\",\"favorite\":\"true\"},{\"id\":\"testId3\",\"name\":\"testName1\",\"sets\":\"2\",\"reps\":\"2000\",\"favorite\":\"false\"}]},\"archive\":[{\"date\":\"2022-10-22 00:00:00.000\",\"points\":\"12342435235\"},{\"date\":\"2022-10-22 00:00:00.000\",\"points\":\"123424352356\"},{\"date\":\"2022-10-22 00:00:00.000\",\"points\":\"123424352357\"}],\"scheduler\":[]}";
    var decodedJsonMap = jsonDecode(jsonBlob);
    // Map<String, Dynamic>
    Config c = Config.fromJson(decodedJsonMap);
    c.listLibrary();
    c.listArchive();
    return Container();
  }
}

import 'dart:core';
import 'package:uuid/uuid.dart';

import 'activity.dart';

class Break extends Activity {
  late String _id;
  late Duration _duration;

  Break(Duration d) {
    _duration = d; // int!
  }

  Break.fromJson(dynamic d) {
    _duration = Duration(
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: int.parse(d['duration']),
        milliseconds: 0,
        microseconds: 0);
    _id = d['id'];
  }

  @override
  String getId() {
    return _id;
  }
}

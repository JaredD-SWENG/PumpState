import 'dart:core';
import 'package:uuid/uuid.dart';

import 'activity.dart';

class Break extends Activity {
  late String _id;
  late Duration _duration;

  Break(Duration d) {
    _id = Uuid().v4();
    _duration = d; // int!
  }

  Break.fromJson(dynamic d) {
    _duration = Duration(days: 0, hours: 0, minutes: 0, seconds: int.parse(d['duration']), milliseconds: 0, microseconds: 0);
    _id = d['id'];
  }

  @override
  Map<String, dynamic> toJson() => {'id': _id, 'duration': _duration.inSeconds};

  @override
  String getId() {
    return _id;
  }

  @override
  String getName() {
    return '${_duration.inSeconds} seconds';
  }
}

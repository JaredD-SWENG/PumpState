import 'dart:core';
import 'package:uuid/uuid.dart';
import 'activity.dart';

/// Break is a type of Activity that defines a wait time between sets or exercises
class Break extends Activity {
  late String _id;
  late Duration _duration;

  /// Default constructor
  Break(Duration d) {
    _id = Uuid().v4();
    _duration = d; // int!
  }

  /// Constructor to generate Object from JSON
  Break.fromJson(dynamic d) {
    _duration = Duration(days: 0, hours: 0, minutes: 0, seconds: (d['duration']), milliseconds: 0, microseconds: 0);
    _id = d['id'];
  }

  /// Overridden function from Activity abstract class
  /// Generates a JSON string of Break
  @override
  Map<String, dynamic> toJson() => {'id': _id, 'duration': _duration.inSeconds};

  /// Overridden function from Activity abstract class.
  /// Returns the ID of the Break
  @override
  String getId() {
    return _id;
  }

  /// Overridden function from Activity abstract class
  /// Returns the duration of this Break as string value
  @override
  String getName() {
    return '${_duration.inSeconds} seconds';
  }

  /// Returns the duration of this Break as duration value
  Duration getDuration() {
    return _duration;
  }
}

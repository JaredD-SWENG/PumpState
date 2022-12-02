import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/classes/scheduledWorkout.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/schedule-workout-form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/table-calendar.dart';

class SchedulerScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends ConsumerState<SchedulerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient()),
      child: Center(child: Calendar()),
    );
  }
}

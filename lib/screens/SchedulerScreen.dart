import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pump_state/classes/scheduledWorkout.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/schedule-workout-form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends ConsumerState<SchedulerScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient()),
      child: Center(
        child: TableCalendar(
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2022, 12, 31),
          focusedDay: DateTime.now(),
          eventLoader: (day) {
            return ref.read(configProvider).scheduler.getSW(day);
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });
            showModalBottomSheet(
                enableDrag: false,
                context: context,
                builder: (context) {
                  return ScheduleWorkoutForm(selectedDate: _selectedDay);
                });
          },
        ),
      ),
    );
  }
}

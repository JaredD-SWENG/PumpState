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

            if(ref.read(configProvider).library.workouts.isEmpty){
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: Color.fromRGBO(48, 47, 47, 1.0),
                    title: const Text('Alert Dialog'),
                    content: const Text('Before Scheduling a Workout, please go to the "Workouts" library to create your custom Workout.', style: TextStyle(color: Colors.red, fontSize: 20.00)),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK', style: TextStyle(color: Colors.white),))
                    ],
                  ));
            }
            else {
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
            }},
        ),
      ),
    );
  }
}

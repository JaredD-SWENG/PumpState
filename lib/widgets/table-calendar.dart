import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/widgets/schedule-workout-form.dart';
import 'package:table_calendar/table_calendar.dart';

import '../providers/config-provider.dart';
import '../styles/styles.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  ConsumerState<Calendar> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {
  DateTime _selectedDay = DateTime.now();

  void setSelectedDayToNow() {
    setState(() {
      _selectedDay = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(color: whiteOut(), shape: BoxShape.circle),
          todayTextStyle: TextStyle(color: Colors.black),
          selectedDecoration: BoxDecoration(color: creek(), shape: BoxShape.circle),
          weekendTextStyle: TextStyle(color: limestone()),
          markerDecoration: BoxDecoration(color: pennsylvaniaSky(), shape: BoxShape.circle),
          defaultTextStyle: TextStyle(
            color: whiteOut(),
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleTextStyle: Theme.of(context).textTheme.headline6!,
          titleCentered: true,
        ),
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            String weekday = "";
            switch (day.weekday) {
              case 1:
                weekday = "M";
                break;
              case 2:
                weekday = "T";
                break;
              case 3:
                weekday = "W";
                break;
              case 4:
                weekday = "T";
                break;
              case 5:
                weekday = "F";
                break;
              case 6:
                weekday = "S";
                break;
              case 7:
                weekday = "S";
                break;
            }
            return Text(
              weekday,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: whiteOut(),
              ),
            );
          },
        ),
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2025, 12, 31),
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
          });
          showModalBottomSheet(
              enableDrag: false,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return ScheduleWorkoutForm(
                  selectedDate: _selectedDay,
                  setDateToToday: setSelectedDayToNow,
                );
              });
        },
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:pump_state/classes/completedWorkout.dart';
import 'package:pump_state/classes/scheduledWorkout.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/styles/styles.dart';

import '../classes/config.dart';
import '../classes/file-io.dart';
import '../classes/workout.dart';

class ScheduleWorkoutForm extends ConsumerStatefulWidget {
  final DateTime selectedDate;
  final Function setDateToToday;

  const ScheduleWorkoutForm({Key? key, required this.selectedDate, required this.setDateToToday}) : super(key: key);

  @override
  ConsumerState<ScheduleWorkoutForm> createState() => _SchedulerWorkoutFormState();
}

String getMonth(int m) {
  switch (m) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return 'Unknown';
  }
}

class _SchedulerWorkoutFormState extends ConsumerState<ScheduleWorkoutForm> {
  late DateTime selectedTime;
  late Workout selectedWorkout;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedTime = widget.selectedDate;
    selectedWorkout = ref.read(configProvider).library.workouts.first;
  }

  void setSelectedTime(DateTime d) {
    setState(() {
      selectedTime = DateTime(selectedTime.year, selectedTime.month, selectedTime.day, d.hour, d.minute, 0, 0, 0);
      print(selectedTime.toString());
    });
  }

  void saveScheduledWorkout(BuildContext context) {
    ScheduledWorkout sw = ScheduledWorkout.fromCalendar(selectedTime, selectedWorkout);
    Config c = Config.newState(ref.read(configProvider).library, ref.read(configProvider).archive, ref.read(configProvider).scheduler);
    c.scheduler.scheduleWorkout(sw);
    ref.read(configProvider.notifier).state = c;
    FileIO.writeConfig(c);
    widget.setDateToToday();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: [
          Card(
            child: TimePickerSpinner(
              normalTextStyle: TextStyle(color: whiteOut()),
              highlightedTextStyle: TextStyle(color: whiteOut(), fontWeight: FontWeight.bold),
              itemHeight: 50,
              spacing: 10,
              is24HourMode: false,
              onTimeChange: (d) {
                setSelectedTime(d);
              },
            ),
          ),
          DropdownButton(
            value: selectedWorkout,
            items: ref.read(configProvider).library.getWorkouts().map<DropdownMenuItem<Workout>>((Workout w) {
              return DropdownMenuItem<Workout>(
                  value: w,
                  child: Text(
                    w.getName(),
                    style: TextStyle(),
                  ));
            }).toList(),
            onChanged: (w) {
              setState(() {
                selectedWorkout = w!;
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                saveScheduledWorkout(context);
              },
              child: const Text(
                'Schedule Workout',
                style: TextStyle(color: Colors.black),
              )),
          Container(
            height: 200,
            child: ListView(
              children: <Widget>[
                for (ScheduledWorkout sw in ref.read(configProvider).scheduler.getSW(widget.selectedDate))
                  Dismissible(
                    key: UniqueKey(),
                    child: ListTile(
                      title: Text(sw.scheduledWorkout.getName()),
                    ),
                    onDismissed: (DismissDirection horizontal) {
                      Config c =
                          Config.newState(ref.read(configProvider).library, ref.read(configProvider).archive, ref.read(configProvider).scheduler);
                      c.scheduler.getSchedule().remove(sw);
                      ref.read(configProvider.notifier).state = c;
                      FileIO.writeConfig(c);
                      widget.setDateToToday();
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

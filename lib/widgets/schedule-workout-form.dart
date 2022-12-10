import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:pump_state/classes/scheduledWorkout.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/styles/styles.dart';

import '../classes/config.dart';
import '../classes/file-io.dart';
import '../classes/workout.dart';

/// Bottom modal for scheduling a workout.
/// Allows user to select time and workout
/// Allows uer to remove (by dimissing) scheduled workouts
class ScheduleWorkoutForm extends ConsumerStatefulWidget {
  final DateTime selectedDate;
  final Function setDateToToday;

  const ScheduleWorkoutForm({Key? key, required this.selectedDate, required this.setDateToToday}) : super(key: key);

  @override
  ConsumerState<ScheduleWorkoutForm> createState() => _SchedulerWorkoutFormState();
}

class _SchedulerWorkoutFormState extends ConsumerState<ScheduleWorkoutForm> {
  late DateTime selectedTime;
  late Workout selectedWorkout;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedTime = widget.selectedDate; // Sets the state to the selected date from the TableCalendar
    selectedWorkout = ref.read(configProvider).library.workouts.first;
  }

  /// Sets the selected time from the time picker wheel
  void setSelectedTime(DateTime d) {
    setState(() {
      selectedTime = DateTime(selectedTime.year, selectedTime.month, selectedTime.day, d.hour, d.minute, 0, 0, 0);
    });
  }

  /// Saves the scheduled workout
  void saveScheduledWorkout(BuildContext context) {
    ScheduledWorkout sw = ScheduledWorkout.fromCalendar(selectedTime, selectedWorkout); // Create scheduled workout
    Config c = Config.newState(
        ref.read(configProvider).library, ref.read(configProvider).archive, ref.read(configProvider).scheduler); // Create new config state
    c.scheduler.scheduleWorkout(sw); // Add scheduled workout to scheduler
    ref.read(configProvider.notifier).state = c; // Update app state
    FileIO.writeConfig(c); // Update config
    widget.setDateToToday(); // Reset the day to today
    Navigator.pop(context); // Pop the bottom modal
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
        height: MediaQuery.of(context).size.height * .4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: slate(),
        ),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      height: MediaQuery.of(context).size.height * .15,
                      width: MediaQuery.of(context).size.width * .5,
                      child: Card(
                        color: beaverBlue(),
                        child: TimePickerSpinner(

                          normalTextStyle: TextStyle(color: whiteOut()),
                          highlightedTextStyle: TextStyle(color: whiteOut(), fontWeight: FontWeight.bold),
                          itemHeight: 30,
                          itemWidth: 40,
                          spacing: 4,
                          is24HourMode: false,
                          onTimeChange: (d) {
                            setSelectedTime(d);
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child:Column(
                        children: [
                           Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: creek(),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                                height: MediaQuery.of(context).size.height * .08,
                                child: Card(
                                  color: beaverBlue(),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: creek(),
                                    ),
                                    value: selectedWorkout,
                                    items: ref.read(configProvider).library.getWorkouts().map<DropdownMenuItem<Workout>>((Workout w) {
                                      return DropdownMenuItem<Workout>(
                                          value: w,
                                          child: Text(
                                            w.getName(),
                                            style: TextStyle(
                                              color: whiteOut(),
                                            ),
                                          ));
                                    }).toList(),
                                    onChanged: (w) {
                                      setState(() {
                                        selectedWorkout = w!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),

                           ElevatedButton(
                                onPressed: () {
                                  saveScheduledWorkout(context);
                                },
                                child: const Text(
                                  'Schedule Workout',
                                  style: TextStyle(color: Colors.black),
                                ))
                        ],
                      ) ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height * .15,
                  width: MediaQuery.of(context).size.width * .65,
                  child: Card(
                    color: beaverBlue(),
                    child: RawScrollbar(
                      thumbVisibility: true,
                      thickness: 2.25,
                      radius: const Radius.circular(5),
                      mainAxisMargin: 5,
                      crossAxisMargin: 5,
                      thumbColor: whiteOut(),
                      child: ListView(
                        children: <Widget>[
                          for (ScheduledWorkout sw in ref.read(configProvider).scheduler.getSW(widget.selectedDate))
                            Dismissible(
                              key: UniqueKey(),
                              child: Container(
                                height: MediaQuery.of(context).size.height * .085,
                                child: Card(
                                  color: limestone(),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                          child: Text(
                                        '${sw.scheduledDate.hour % 12}:${sw.scheduledDate.minute}',
                                        style: Theme.of(context).textTheme.headline6,
                                        textAlign: TextAlign.center,
                                      )),
                                      Expanded(
                                        flex: 2,
                                          child: Text(
                                            '${sw.scheduledWorkout.getName()}',
                                            style: Theme.of(context).textTheme.headline6,
                                            textAlign: TextAlign.center,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (DismissDirection horizontal) {
                                Config c = Config.newState(
                                    ref.read(configProvider).library, ref.read(configProvider).archive, ref.read(configProvider).scheduler);
                                c.scheduler.getSchedule().remove(sw);
                                ref.read(configProvider.notifier).state = c;
                                FileIO.writeConfig(c);
                                widget.setDateToToday();
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

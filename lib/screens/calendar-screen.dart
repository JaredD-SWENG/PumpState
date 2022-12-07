import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'package:pump_state/styles/styles.dart';
import 'package:pump_state/widgets/error-card.dart';
import '../widgets/calendar.dart';

/// CalendarScreen contains the TableCalendar widget and is used for the scheduling
/// sequence within the application
/// Uses ephemeral state
class CalendarScreen extends ConsumerWidget {
  final Function changeScreen;

  const CalendarScreen({Key? key, required this.changeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Returns either an ErrorCard if no workouts exist or the calendar
    Widget checkForWorkouts() {
      if (ref.read(configProvider).library.workouts.isEmpty) {
        return ErrorCard(
          changeScreen: changeScreen,
          title: 'No workouts available',
          body: 'Please create a workout before scheduling one',
          screenNumber: 4,
          buttonText: 'Create Workout',
          closeOnButtonPress: false,
        );
      } else {
        return Calendar();
      }
    }

    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient(),
      ),
      child: Center(
        child: checkForWorkouts(),
      ),
    );
  }
}

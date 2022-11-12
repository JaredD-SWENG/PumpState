import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pump_state/screens/calendar-screen.dart';
import 'package:pump_state/screens/home-screen.dart';
import 'package:pump_state/screens/library-activities-screen.dart';
import 'package:pump_state/screens/library-workouts-screen.dart';
import 'package:pump_state/screens/play-screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final titles = ['Home', 'Calendar', 'Play', 'Exercise Library', 'Workout Library'];
  final screens = [HomeScreen(), CalendarScreen(), PlayScreen(), LibraryActivitiesScreen(), LibraryWorkoutScreen()];

  void changeScreen(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(48, 47, 47, 1.0),
        title: Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(48, 47, 47, 1.0),
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (selectedIndex) {
          changeScreen(selectedIndex);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle), label: 'Play'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Exercises'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'Workouts'),
        ],
      ),
    );
  }
}

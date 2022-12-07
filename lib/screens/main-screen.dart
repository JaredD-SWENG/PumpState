import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pump_state/screens/calendar-screen.dart';
import 'package:pump_state/screens/home-screen.dart';
import 'package:pump_state/screens/library-activities-screen.dart';
import 'package:pump_state/screens/library-workouts-screen.dart';
import 'package:pump_state/screens/play-screen.dart';
import 'package:pump_state/styles/styles.dart';

/// Screen that's contents change based on the screen index, used to navigate between bottom nav bar items
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final titles = ['Home', 'Calendar', 'Play Workout', 'Exercise Library', 'Workout Library'];
  late List<Widget> screens;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      HomeScreen(),
      CalendarScreen(changeScreen: changeScreen),
      PlayScreen(
        changeScreen: changeScreen,
      ),
      LibraryActivitiesScreen(),
      LibraryWorkoutScreen(
        changeScreen: changeScreen,
      )
    ];
  }

  /// Function to be based to child widgets to set the state of main's screen index
  void changeScreen(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: slate(),
        title: Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: slate(),
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (selectedIndex) {
          changeScreen(selectedIndex);
        },
        items: const [
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

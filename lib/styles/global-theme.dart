import 'package:flutter/material.dart';
import 'package:pump_state/styles/styles.dart';

ThemeData globalTheme() {
  return ThemeData(
      cardColor: nittanyNavy(),
      unselectedWidgetColor: whiteOut(),
      textTheme: TextTheme(
        headline5: TextStyle(fontWeight: FontWeight.bold, color: whiteOut(), shadows: [Shadow(color: Colors.black, blurRadius: 50)]),
        headline6: TextStyle(color: whiteOut()),
        bodyText1: TextStyle(color: whiteOut()),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shadowColor: MaterialStateColor.resolveWith((states) => Colors.black),
              backgroundColor: MaterialStateColor.resolveWith((states) => creek()))),
      iconTheme: const IconThemeData(
        size: 30,
      ),
      switchTheme: SwitchThemeData(
          thumbColor: MaterialStateColor.resolveWith((states) => nittanyNavy()),
          trackColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? whiteOut() : Colors.black)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: creek()),
      appBarTheme: AppBarTheme(color: slate()),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: creek(),
      ),
      cardTheme: CardTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))));
}

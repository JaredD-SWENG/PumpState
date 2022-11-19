import 'package:flutter/material.dart';
import 'package:pump_state/styles/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: backgroundGradient()),
        child: const Center(
          child: Text('This is filler for home'),
        ));
  }
}

import 'package:flutter/material.dart';

///styles.dart implements many custom color choices, these color choices are called throughout PumpState.

Color pennsylvaniaSky() {
  return const Color.fromRGBO(0, 156, 222, 1);
}

Color nittanyNavy() {
  return const Color.fromRGBO(4, 30, 66, 1);
}

Color beaverBlue() {
  return const Color.fromRGBO(30, 64, 124, 1.0);
}

Color whiteOut() {
  return const Color.fromRGBO(255, 255, 255, 1);
}

Color limestone() {
  return const Color.fromRGBO(162, 170, 173, 1);
}

Color slate() {
  return const Color.fromRGBO(49, 77, 100, 1);
}

Color creek() {
  return const Color.fromRGBO(62, 163, 158, 1);
}

///backgroundGradient is a function that returns the gradient background used in many main screens throughout the PumpState App.
LinearGradient backgroundGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      slate(),
      beaverBlue(),
    ],
  );
}

///cardBoxShadow is a function that returns the shadow color used by Card widgets throughout the PumpState App.
BoxShadow cardBoxShadow() {
  return const BoxShadow(
    color: Colors.black26,
    spreadRadius: 1,
    blurRadius: 5,
    offset: Offset(0, 3),
  );
}

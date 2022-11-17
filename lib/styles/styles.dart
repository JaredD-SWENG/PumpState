import 'package:flutter/material.dart';

Color pumpStateBlue() {
  return const Color.fromRGBO(0, 156, 222, 1);
}

Color beaverBlue() {
  return const Color.fromRGBO(4, 30, 66, 1);
}

Color pumpStateDarkBlue() {
  return const Color.fromRGBO(30, 64, 124, 1.0);
}

Color whiteOut() {
  return const Color.fromRGBO(255, 255, 255, 1);
}

Color limestone() {
  return const Color.fromRGBO(162, 170, 173, 1);
}

BoxDecoration linearGradient() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        pumpStateBlue(),
        pumpStateDarkBlue(),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

BoxDecoration linearGradient() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(0, 156, 222, 1),
        Color.fromRGBO(30, 64, 124, 1.0),
      ],
    ),
  );
}

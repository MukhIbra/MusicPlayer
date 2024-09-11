import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade400,
    secondary: Colors.grey.shade200,
    inversePrimary: Colors.grey.shade900,
  )
);

ThemeData darkmode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.grey.shade900,
        primary: Colors.grey.shade600,
        secondary: Colors.grey.shade800,
        inversePrimary: Colors.grey.shade300
    )
);
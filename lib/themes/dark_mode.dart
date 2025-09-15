import 'package:flutter/material.dart';

ThemeData darkModeTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade500,
    secondary: const Color.fromARGB(255, 41, 41, 41),
    tertiary: const Color.fromARGB(255, 25, 25, 25),
    inversePrimary: Colors.grey.shade300
  ),

  scaffoldBackgroundColor: Colors.grey.shade900
);
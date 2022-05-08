import 'package:flutter/material.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

final appThemeData = {
  AppTheme.lightTheme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.indigo,
  ),
  AppTheme.darkTheme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo[800],
  )
};

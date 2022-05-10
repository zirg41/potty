import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

final appThemeData = {
  AppTheme.lightTheme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.indigo,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.lato(fontSize: 25),
    ),
  ),
  AppTheme.darkTheme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo[800],
    textTheme: TextTheme(
      titleLarge: GoogleFonts.lato(fontSize: 25),
    ),
  )
};

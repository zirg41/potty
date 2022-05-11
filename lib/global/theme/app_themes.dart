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
      bodyLarge: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
      bodyMedium: GoogleFonts.lato(fontSize: 15),
      bodySmall: GoogleFonts.lato(fontSize: 12),
    ),
  ),
  AppTheme.darkTheme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo[800],
    textTheme: TextTheme(
      titleLarge: GoogleFonts.lato(fontSize: 25),
      bodyLarge: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
      bodyMedium: GoogleFonts.lato(fontSize: 15),
      bodySmall: GoogleFonts.lato(fontSize: 12),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkThemePalette['green'],
      foregroundColor: Colors.white70,
      // extendedTextStyle: GoogleFonts.lato(),
    ),
  )
};

const darkThemePalette = {
  'darkblue': Color(0xFF044c6d),
  'green': Color(0xFF094b5a),
  'darkgreen': Color(0xFF002431),
  'maroon': Color(0xFF1f0001),
  'vinous': Color(0xFF6d0101),
};

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
    // TODO light Colorscheme should be added
  ),
  AppTheme.darkTheme: ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.lato(fontSize: 25),
      bodyLarge: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
      bodyMedium: GoogleFonts.lato(fontSize: 15),
      bodySmall: GoogleFonts.lato(fontSize: 12),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: pottyPalette['Charcoal'],
      onSecondary: Colors.white70,
      primary: Color.fromARGB(255, 75, 75, 75),
      surface: const Color.fromARGB(255, 43, 43, 43),
      background: const Color(0xFF121212),
      tertiary: const Color.fromARGB(255, 203, 122, 60),
      outline: const Color.fromARGB(255, 70, 70, 70),
      error: Colors.red,
    ),
  ),
};

const darkThemePalette = {
  'darkblue': Color(0xFF044c6d),
  'green': Color(0xFF094b5a),
  'darkgreen': Color(0xFF002431),
  'maroon': Color(0xFF1f0001),
  'vinous': Color(0xFF6d0101),
};
const pottyPalette = {
  'Charcoal': Color(0xFF264653),
  'Persian Green': Color(0xFF2A9D8F),
  'Maize Crayola': Color(0xFFE9C46A),
  'Sandy Brown': Color(0xFFE76F51),
  'Burnt Sienna': Color(0xFFE76F51),
};

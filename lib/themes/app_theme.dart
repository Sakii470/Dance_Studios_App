// lib/themes/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Definicja pierwotnego swatcha kolorów
  static const MaterialColor primarySwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFF5E4F5),
      100: Color(0xFFE1BADF),
      200: Color(0xFFCE8EC9),
      300: Color(0xFFBA61B2),
      400: Color(0xFFAA419F),
      500: Color(0xFF9A1F8C),
      600: Color(0xFF8A1C7E),
      700: Color(0xFF78196F),
      800: Color(0xFF661660),
      900: Color(0xFF281733),
    },
  );
  static const int _primaryValue = 0xFF4A154B;

  // Aktualizacja darkTheme
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: primarySwatch,
    scaffoldBackgroundColor: primarySwatch[900], // Najciemniejszy kolor
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF9A1F8C),
      secondary: Color(0xFFCE8EC9),
      background: Color(0xFF1A0B20),
      surface: Color(0xFF26102E),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
      bodySmall: TextStyle(fontSize: 12, color: Colors.white70),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFCE8EC9), // Użycie konkretnego koloru z primarySwatch
      size: 24,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFCE8EC9), // Primary dark color
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF4A154B), // Dark Purple
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: Color(0xFFCE8EC9),
      labelStyle: TextStyle(color: Colors.white),
      padding: EdgeInsets.all(4),
      shape: StadiumBorder(),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white24,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      labelStyle: TextStyle(color: Colors.white),
      prefixIconColor: Colors.white,
    ),
  );
}

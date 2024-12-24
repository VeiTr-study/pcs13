import 'package:flutter/material.dart';
final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    labelStyle: TextStyle(color: Colors.black), // Label text color
    hintStyle: TextStyle(color: Colors.black), // Hint text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black), // Border color when enabled
    ),
    floatingLabelStyle: TextStyle(color: Colors.black), // Label color when focused
  ),
  cardTheme: const CardTheme(
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    elevation: 4,
  ),
);
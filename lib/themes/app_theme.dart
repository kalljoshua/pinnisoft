import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.purple,
    scaffoldBackgroundColor: Color(0xFF181A2E),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white70),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black45,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      hintStyle: TextStyle(color: Colors.white54),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.green,
      thumbColor: Colors.greenAccent,
      overlayColor: Colors.green.withOpacity(0.2),
    ),
  );
}

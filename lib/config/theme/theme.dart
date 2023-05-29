import 'package:flutter/material.dart';

class AppTheme {
  final _lightTheme = ThemeData(
    primarySwatch: Colors.blue,
  );
  final _darkTheme = ThemeData.dark();

  ThemeData get getLightTheme => _lightTheme;
  ThemeData get getDarkTheme => _darkTheme;
}

import 'package:flutter/material.dart';

final class AppTheme {
  factory AppTheme() {
    return _singleton;
  }

  AppTheme._internal();
  static final AppTheme _singleton = AppTheme._internal();

  final _lightTheme = ThemeData(
    primarySwatch: Colors.blue,
  );
  final _darkTheme = ThemeData.dark();

  ThemeData get getLightTheme => _lightTheme;
  ThemeData get getDarkTheme => _darkTheme;
}

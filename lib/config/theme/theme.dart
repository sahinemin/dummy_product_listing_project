import 'package:flutter/material.dart';

final class AppTheme {
  factory AppTheme() {
    return _singleton;
  }

  AppTheme._internal();
  static final AppTheme _singleton = AppTheme._internal();

  final _lightTheme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  final _darkTheme = ThemeData.dark(useMaterial3: true);

  ThemeData get getLightTheme => _lightTheme;
  ThemeData get getDarkTheme => _darkTheme;
}

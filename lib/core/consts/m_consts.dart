import 'package:flutter/material.dart';

abstract class MConstants {
  static const List<Locale> locales = [
    Locale('en', 'US'),
    Locale('fr', 'IR'),
  ];

  static const List<ThemeMode> themeModes = [
    ThemeMode.system,
    ThemeMode.light,
    ThemeMode.dark
  ];
}

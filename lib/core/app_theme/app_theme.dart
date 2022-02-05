import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData getTheme(ThemeMode themeMode) {
    return themeMode == ThemeMode.system
        ? lightTheme
        : themeMode == ThemeMode.dark
            ? darkTheme
            : lightTheme;
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black45),
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Color(0xff1A1F2C),
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xff1A1F2C)),
        fixedSize: MaterialStateProperty.all(const Size(double.infinity, 58)),
      )),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFF1F5F9),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xff000000),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        color: Color(0xff000000),
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xff5E5CE5)),
        fixedSize: MaterialStateProperty.all(const Size(double.infinity, 58)),
      )),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF3A3A3C),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  static Widget textFieldPrefixIcon(Widget prefix) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: prefix,
    );
  }

  static BoxConstraints get textFieldPrefixConstraint =>
      const BoxConstraints(minHeight: 0, minWidth: 0);
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData buildLightTheme() {
  return ThemeData(
    primarySwatch: Colors.teal,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: darkBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
  );
}

const Color darkBackgroundColor = Color(0xFF24292E);

ThemeData buildDarkTheme() {
  final ThemeData dark = ThemeData.dark();
  return ThemeData(
    primarySwatch: Colors.teal,
    backgroundColor: darkBackgroundColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: darkBackgroundColor,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      elevation: 0,
    ),
    textTheme: dark.textTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkBackgroundColor,
      unselectedItemColor: Colors.grey,
    ),
  );
}

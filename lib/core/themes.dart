import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData buildLightTheme(BuildContext context) {
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

ThemeData buildDarkTheme(BuildContext context) {
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
      ),
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyText1: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.white,
          ),
      caption: Theme.of(context).textTheme.caption!.copyWith(
            color: Colors.grey,
          ),
      headline4: Theme.of(context).textTheme.headline4!.copyWith(
            color: Colors.white,
          ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkBackgroundColor,
      unselectedItemColor: Colors.grey,
    ),
  );
}

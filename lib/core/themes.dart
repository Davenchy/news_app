import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.teal,
);

const Color darkBackgroundColor = Color(0xFF24292E);

ThemeData buildDarkTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.teal,
    backgroundColor: darkBackgroundColor,
    scaffoldBackgroundColor: darkBackgroundColor,
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

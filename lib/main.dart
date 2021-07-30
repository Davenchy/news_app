import 'package:flutter/material.dart';
import 'package:news_app/core/themes.dart';
import 'package:news_app/screens/layouts/home_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: HomeLayout(),
    );
  }
}

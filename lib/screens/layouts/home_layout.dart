import 'package:flutter/material.dart';
import 'package:news_app/models/navigator_screen_item.dart';
import 'package:news_app/screens/technology_screen.dart';

class HomeLayout extends StatelessWidget {
  // TODO: add const
  HomeLayout({Key? key}) : super(key: key);

  final List<NavigatorScreenItem> screens = [
    NavigatorScreenItem(
      label: 'Technology',
      icon: Icons.touch_app_outlined,
      screen: Container(),
    ),
    NavigatorScreenItem(
      label: 'Science',
      icon: Icons.science,
      screen: Container(),
    ),
    NavigatorScreenItem(
      label: 'Health',
      icon: Icons.healing,
      screen: Container(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        brightness: Brightness.dark,
        actions: [
          IconButton(
            onPressed: () => null,
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => null,
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: screens
            .map<BottomNavigationBarItem>((e) => e.toBottomNavigationBarItem())
            .toList(),
      ),
      body: TechnologyScreen(),
    );
  }
}

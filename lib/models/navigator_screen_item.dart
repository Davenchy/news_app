import 'package:flutter/material.dart';

class NavigatorScreenItem {
  final String label;
  final IconData icon;
  final Widget screen;

  const NavigatorScreenItem({
    required this.label,
    required this.icon,
    required this.screen,
  });

  BottomNavigationBarItem toBottomNavigationBarItem() =>
      BottomNavigationBarItem(
        icon: Icon(icon),
        label: label,
      );
}

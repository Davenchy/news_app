import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/navigator_screen_item.dart';
import 'package:news_app/screens/health_screen.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/technology_screen.dart';
import 'package:news_app/services/news_services.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._newsServices) : super(const AppInitialState());

  final NewsService _newsServices;
  int _currentScreenIndex = 0;
  final List<NavigatorScreenItem> _screens = [
    NavigatorScreenItem(
      label: 'Technology',
      icon: Icons.touch_app_outlined,
      screen: TechnologyScreen(),
    ),
    NavigatorScreenItem(
      label: 'Science',
      icon: Icons.science,
      screen: ScienceScreen(),
    ),
    NavigatorScreenItem(
      label: 'Health',
      icon: Icons.healing,
      screen: HealthScreen(),
    ),
  ];

  int get selectedScreenIndex => _currentScreenIndex;
  Widget get currentScreen => screens[selectedScreenIndex].screen;
  List<NavigatorScreenItem> get screens => List.unmodifiable(_screens);

  void selectScreen(int screenIndex) {
    assert(
      screenIndex >= 0 && screenIndex < screens.length,
      'screen_index must be in range [0, ${screens.length - 1}]',
    );

    _currentScreenIndex = screenIndex;
    emit(AppChangedScreenState(screenIndex));

    // TODO: fetch screen content
  }
}

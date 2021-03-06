import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeAppliedState(false)) {
    _isDarkMode = _isSystemDarkModeEnabled;
    _loadThemeMode();
  }

  static ThemeCubit of(BuildContext context) => context.read<ThemeCubit>();
  static Future<void> toggleDarkModeOf(BuildContext context) =>
      of(context).toggleDarkMode();
  static bool isDarkModeOf(BuildContext context) => of(context).isDarkMode;

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  static bool _isSystemDarkModeEnabled = false;

  static void loadSystemDarkModeState() {
    final SchedulerBinding? schedulerBinding = SchedulerBinding.instance;
    if (schedulerBinding != null) {
      _isSystemDarkModeEnabled = _isSystemEnabledDarkMode();
    }
  }

  static bool _isSystemEnabledDarkMode() {
    final SchedulerBinding? schedulerBinding = SchedulerBinding.instance;
    if (schedulerBinding == null) return false;
    return schedulerBinding.window.platformBrightness != Brightness.light;
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    await _saveThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isDarkModePrefs = prefs.getBool('isDarkMode');

    if (isDarkModePrefs != null) {
      _isDarkMode = isDarkModePrefs;
    }

    emit(ThemeAppliedState(_isDarkMode));
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    emit(ThemeAppliedState(_isDarkMode));
  }
}

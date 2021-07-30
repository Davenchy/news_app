part of 'theme_cubit.dart';

abstract class ThemeState {
  const ThemeState();
}

class ThemeAppliedState extends ThemeState {
  const ThemeAppliedState(this.isDarkMode);
  final bool isDarkMode;
}

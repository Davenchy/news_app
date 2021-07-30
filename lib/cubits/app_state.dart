part of 'app_cubit.dart';

abstract class AppState {
  const AppState();
}

class AppInitialState extends AppState {
  const AppInitialState();
}

class AppChangedScreenState extends AppState {
  const AppChangedScreenState(this.screenIndex);
  final int screenIndex;
}

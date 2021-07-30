import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/navigator_screen_item.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/models/top_headlines_results.dart';
import 'package:news_app/screens/health_screen.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/technology_screen.dart';
import 'package:news_app/services/news_services.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._newsServices) : super(const AppInitialState());

  static AppCubit of(BuildContext context) => context.read<AppCubit>();

  final NewsService _newsServices;
  final List<NewsArticle> techArticles = [];
  final List<NewsArticle> sciArticles = [];
  final List<NewsArticle> healthArticles = [];

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
  }

  Future<void> fetchTechArticles() async {
    emit(AppFetchingArticlesState());
    techArticles.clear();

    final res = await _newsServices.fetchTechnologyNews();
    if (res is TopHeadLinesErrorResponse) {
      emit(AppFetchErrorResponseState(res));
      return;
    }

    final articles = (res as TopHeadLinesResultsResponse).articles;
    techArticles.addAll(articles);
    emit(AppViewArticlesState(articles));
  }

  Future<void> fetchSciArticles() async {
    emit(AppFetchingArticlesState());
    sciArticles.clear();

    final res = await _newsServices.fetchScienceNews();
    if (res is TopHeadLinesErrorResponse) {
      emit(AppFetchErrorResponseState(res));
      return;
    }

    final articles = (res as TopHeadLinesResultsResponse).articles;
    sciArticles.addAll(articles);
    emit(AppViewArticlesState(articles));
  }

  Future<void> fetchHealthArticles() async {
    emit(AppFetchingArticlesState());
    healthArticles.clear();

    final res = await _newsServices.fetchHealthNews();
    if (res is TopHeadLinesErrorResponse) {
      emit(AppFetchErrorResponseState(res));
      return;
    }

    final articles = (res as TopHeadLinesResultsResponse).articles;
    healthArticles.addAll(articles);
    emit(AppViewArticlesState(articles));
  }
}

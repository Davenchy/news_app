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
  final List<NewsArticle> _techArticles = [];
  final List<NewsArticle> _sciArticles = [];
  final List<NewsArticle> _healthArticles = [];
  final List<NewsArticle> _searchArticles = [];

  List<NewsArticle> get techArticles => List.unmodifiable(_techArticles);
  List<NewsArticle> get sciArticles => List.unmodifiable(_sciArticles);
  List<NewsArticle> get healthArticles => List.unmodifiable(_healthArticles);
  List<NewsArticle> get searchArticles => List.unmodifiable(_searchArticles);

  int _currentScreenIndex = 0;
  static const List<NavigatorScreenItem> _screens = [
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

  Future<void> fetchTechArticles() => _fetchArticlesOf(
        provider: _newsServices.fetchTechnologyNews,
        articlesList: _techArticles,
      );

  Future<void> fetchSciArticles() => _fetchArticlesOf(
        provider: _newsServices.fetchScienceNews,
        articlesList: _sciArticles,
      );

  Future<void> fetchHealthArticles() => _fetchArticlesOf(
        provider: _newsServices.fetchHealthNews,
        articlesList: _healthArticles,
      );

  Future<void> fetchArticles(String query) => _fetchArticlesOf(
        provider: () => _newsServices.searchNews(query),
        articlesList: _searchArticles,
      );

  void clearSearchResults() => _searchArticles.clear();

  Future<void> _fetchArticlesOf({
    required Future<TopHeadlinesResponse> Function() provider,
    required List<NewsArticle> articlesList,
  }) async {
    emit(const AppFetchingArticlesState());
    articlesList.clear();

    final res = await provider();
    if (res is TopHeadLinesErrorResponse) {
      emit(AppFetchErrorResponseState(res));
      return;
    }

    final articles = (res as TopHeadLinesResultsResponse).articles;
    articlesList.addAll(articles);
    await Future.delayed(const Duration(seconds: 1));
    emit(AppViewArticlesState(articles));
  }
}

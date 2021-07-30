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

class AppFetchingArticlesState extends AppState {
  const AppFetchingArticlesState();
}

class AppViewArticlesState extends AppState {
  const AppViewArticlesState(this.articles);
  final List<NewsArticle> articles;
}

class AppFetchErrorResponseState extends AppState {
  const AppFetchErrorResponseState(this.response);
  final TopHeadLinesErrorResponse response;
}

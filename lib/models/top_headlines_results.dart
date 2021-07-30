import 'package:news_app/models/news_article.dart';

class TopHeadlinesResponse {
  const TopHeadlinesResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<NewsArticle> articles;

  factory TopHeadlinesResponse.fromJson(Map<String, dynamic> json) =>
      TopHeadlinesResponse(
        status: json['status'] as String,
        totalResults: json['totalResults'] as int,
        articles: (json['articles'] as List)
            .cast<Map<String, dynamic>>()
            .map<NewsArticle>((json) => NewsArticle.fromJson(json))
            .toList(),
      );

  @override
  String toString() =>
      'TopHeadlines(status: $status, count: $totalResults, articles: $articles)';
}

import 'package:news_app/models/news_article.dart';

abstract class TopHeadlinesResponse {
  const TopHeadlinesResponse({required this.status});
  final String status;

  factory TopHeadlinesResponse.fromJson(Map<String, dynamic> json) {
    final String status = json['status'] as String;
    if (status == 'error') {
      return TopHeadLinesErrorResponse.fromJson(json);
    } else {
      return TopHeadLinesResultsResponse.fromJson(json);
    }
  }

  @override
  String toString() => 'TopHeadlinesResponse(status: $status)';
}

class TopHeadLinesErrorResponse extends TopHeadlinesResponse {
  const TopHeadLinesErrorResponse({
    required String status,
    required this.code,
    required this.message,
  }) : super(status: status);

  final String code;
  final String message;

  factory TopHeadLinesErrorResponse.fromJson(Map<String, dynamic> json) =>
      TopHeadLinesErrorResponse(
        status: json['status'] as String,
        code: json['code'] as String,
        message: json['message'] as String,
      );

  @override
  String toString() =>
      'TopHeadlinesErrorResponse(code: $code, message: $message)';
}

class TopHeadLinesResultsResponse extends TopHeadlinesResponse {
  const TopHeadLinesResultsResponse({
    required String status,
    required this.totalResults,
    required this.articles,
  }) : super(status: status);

  final int totalResults;
  final List<NewsArticle> articles;

  factory TopHeadLinesResultsResponse.fromJson(Map<String, dynamic> json) =>
      TopHeadLinesResultsResponse(
        status: json['status'] as String,
        totalResults: json['totalResults'] as int,
        articles: (json['articles'] as List)
            .cast<Map<String, dynamic>>()
            .map<NewsArticle>((json) => NewsArticle.fromJson(json))
            .toList(),
      );

  @override
  String toString() =>
      'TopHeadlinesResultsResponse(totalResults: $totalResults, articles: $articles)';
}

import 'package:dio/dio.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/models/top_headlines_results.dart';

/// create new news service object
///
/// [options] must has `X-Api-Key` header and `country` query optional
class NewsService {
  const NewsService(this.options);
  final BaseOptions options;

  factory NewsService.create() {
    final BaseOptions options = BaseOptions(
      baseUrl: 'https://newsapi.org/v2',
      headers: {
        'X-Api-Key': apiKey,
      },
      queryParameters: {
        'country': 'eg',
      },
    );
    return NewsService(options);
  }

  Future<TopHeadlinesResponse> _fetchNews({
    String? category,
    String? query,
  }) async {
    final client = Dio(options);

    final Map<String, dynamic> params = {};
    if (category != null) params['category'] = category;
    if (query != null) params['q'] = query;

    final res = await client.get<Map<String, dynamic>>(
      '/top-headlines',
      queryParameters: params,
    );

    final TopHeadlinesResponse topHeadlines =
        TopHeadlinesResponse.fromJson(res.data!);

    client.close();
    return topHeadlines;
  }

  Future<TopHeadlinesResponse> fetchScienceNews() =>
      _fetchNews(category: 'science');

  Future<TopHeadlinesResponse> fetchTechnologyNews() =>
      _fetchNews(category: 'technology');

  Future<TopHeadlinesResponse> fetchHealthNews() =>
      _fetchNews(category: 'health');

  Future<TopHeadlinesResponse> searchNews(String query) =>
      _fetchNews(query: query);
}

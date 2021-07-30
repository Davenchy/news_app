import 'package:dio/dio.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/models/top_headlines_results.dart';

/// create new news service object
///
/// [options] must has `X-Api-Key` header and `country` query optional
class NewsServices {
  const NewsServices(this.options);
  final BaseOptions options;

  factory NewsServices.create() {
    final BaseOptions options = BaseOptions(
      baseUrl: 'https://newsapi.org/v2',
      headers: {
        'X-Api-Key': API_KEY,
      },
      queryParameters: {
        'country': 'eg',
      },
    );
    return NewsServices(options);
  }

  Future<TopHeadlinesResponse> _fetchNews(String category) async {
    final client = Dio(options);

    final res = await client.get<Map<String, dynamic>>(
      '/top-headlines',
      queryParameters: {
        'category': category,
      },
    );

    final TopHeadlinesResponse topHeadlines =
        TopHeadlinesResponse.fromJson(res.data!);

    // TODO: handle errors

    client.close();
    return topHeadlines;
  }

  Future<TopHeadlinesResponse> fetchScienceNews() => _fetchNews('science');

  Future<TopHeadlinesResponse> fetchTechnologyNews() =>
      _fetchNews('technology');

  Future<TopHeadlinesResponse> fetchHealthNews() => _fetchNews('health');
}

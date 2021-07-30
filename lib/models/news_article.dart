class NewsArticle {
  const NewsArticle({
    required this.title,
    required this.url,
    this.imgUrl,
    required this.publishedAt,
  });

  final String title;
  final String url;
  final String? imgUrl;
  final DateTime publishedAt;

  factory NewsArticle.fromJson(Map<String, dynamic> json) => NewsArticle(
        title: json['title'] as String,
        url: json['url'] as String,
        imgUrl: json['urlToImage'] as String?,
        publishedAt:
            DateTime.tryParse(json['publishedAt'] as String) ?? DateTime.now(),
      );

  @override
  String toString() => 'NewsArticle(title: $title, publishedAt: $publishedAt)';
}

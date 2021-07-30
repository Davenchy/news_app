import 'package:flutter/material.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/widgets/article_item.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({
    Key? key,
    required this.articles,
    required this.onRefresh,
    this.isFetching = false,
  }) : super(key: key);

  final List<NewsArticle> articles;
  final bool isFetching;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isFetching
          ? _buildLoadingState()
          : articles.isEmpty
              ? _buildNoArticles(context)
              : _buildArticlesList(context),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildArticlesList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        itemCount: articles.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          final article = articles[index];
          return ArticleItem(article);
        },
      ),
    );
  }

  Widget _buildNoArticles(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: Colors.amber,
          size: 120.0,
        ),
        SizedBox(height: 30.0),
        Text(
          'No Articles',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 30.0),
        SizedBox(
          width: 200,
          height: 50.0,
          child: ElevatedButton(
            onPressed: onRefresh,
            child: Text(
              'REFRESH',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/widgets/article_item.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({
    Key? key,
    required this.articles,
    required this.onRefresh,
    this.isFetching = false,
    this.showWarningIcon = true,
    this.showRefreshButton = true,
    this.noArticles,
  }) : super(key: key);

  final List<NewsArticle> articles;
  final bool isFetching;
  final Future<void> Function() onRefresh;
  final bool showWarningIcon;
  final bool showRefreshButton;
  final Widget? noArticles;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isFetching
          ? _buildLoadingState(context)
          : articles.isEmpty
              ? noArticles ?? _buildNoArticles(context)
              : _buildArticlesList(context),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: SpinKitChasingDots(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildArticlesList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        itemCount: articles.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final article = articles[index];
          return ArticleItem(article);
        },
      ),
    );
  }

  Widget _buildNoArticles(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showWarningIcon)
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.amber,
              size: 120.0,
            ),
          if (showWarningIcon) const SizedBox(height: 30.0),
          Text(
            'No Articles',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          if (showRefreshButton) const SizedBox(height: 30.0),
          if (showRefreshButton)
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: onRefresh,
                child: const Text(
                  'REFRESH',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

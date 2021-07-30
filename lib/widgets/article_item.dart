import 'package:flutter/material.dart';
import 'package:news_app/models/news_article.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem(this.article, {Key? key}) : super(key: key);
  final NewsArticle article;

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width * .3;
    return SizedBox(
      height: w,
      child: article.imgUrl == null
          ? _buildArticleBody(context, article)
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    article.imgUrl!,
                    width: w,
                    height: w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _buildArticleBody(context, article),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildArticleBody(BuildContext context, NewsArticle article) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          article.publishedAt.toString(),
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

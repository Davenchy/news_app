import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/screens/view_article_screen.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem(this.article, {Key? key}) : super(key: key);
  final NewsArticle article;

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width * .3;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ViewArticleScreen(article.url),
          fullscreenDialog: true,
        ),
      ),
      child: SizedBox(
        height: w,
        child: article.imgUrl == null
            ? _buildArticleBody(context, article)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: SizedBox(
                      width: w,
                      height: w,
                      child: Image.network(
                        article.imgUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) {
                          return const SizedBox.expand(
                            child: Icon(
                              Icons.warning_amber_outlined,
                              color: Colors.red,
                              size: 40.0,
                            ),
                          );
                        },
                        loadingBuilder: (context, image, event) {
                          if (event == null) {
                            return image;
                          } else {
                            return SizedBox.expand(
                              child: Center(
                                child: SpinKitCubeGrid(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _buildArticleBody(context, article),
                    ),
                  ),
                ],
              ),
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
          maxLines: 3,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          Intl().date('MMMM d, yyyy - hh:mm a').format(article.publishedAt),
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

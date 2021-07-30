import 'package:flutter/material.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/widgets/article_item.dart';

class TechnologyScreen extends StatelessWidget {
  const TechnologyScreen({Key? key}) : super(key: key);

  static const String image =
      'https://cdn.abcotvs.com/dip/images/10918729_073021-wls-cook-mask-jess430a-vid.jpg?w=1600';

  @override
  Widget build(BuildContext context) {
    return _buildArticlesList(context);
  }

  Widget _buildArticlesList(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      itemCount: 10,
      separatorBuilder: (_, __) => SizedBox(height: 16.0),
      itemBuilder: (context, index) {
        final article = NewsArticle(
          title: 'Article Title',
          imgUrl: image,
          url: '',
          publishedAt: DateTime.now(),
        );

        return ArticleItem(article);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/models/news_article.dart';

class TechnologyScreen extends StatelessWidget {
  const TechnologyScreen({Key? key}) : super(key: key);

  static const String image =
      'https://cdn.abcotvs.com/dip/images/10918729_073021-wls-cook-mask-jess430a-vid.jpg?w=1600';

  @override
  Widget build(BuildContext context) {
    return _buildArticlesList(context);
  }

  Widget _buildArticlesList(BuildContext context) {
    final double w = MediaQuery.of(context).size.width * .3;

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
      },
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

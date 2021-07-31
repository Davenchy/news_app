import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/app_cubit.dart';
import 'package:news_app/widgets/articles_list.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, current) =>
          current is AppFetchingArticlesState ||
          current is AppViewArticlesState ||
          current is AppFetchErrorResponseState,
      builder: (context, state) {
        final cubit = AppCubit.of(context);
        return ArticleList(
          articles: cubit.healthArticles,
          onRefresh: cubit.fetchHealthArticles,
          isFetching: state is AppFetchingArticlesState,
        );
      },
    );
  }
}

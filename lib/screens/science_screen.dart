import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/app_cubit.dart';
import 'package:news_app/widgets/articles_list.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, current) =>
          current is AppFetchingArticlesState ||
          current is AppViewArticlesState,
      builder: (context, state) {
        final cubit = AppCubit.of(context);
        return ArticleList(
          articles: cubit.sciArticles,
          onRefresh: cubit.fetchSciArticles,
          isFetching: state is AppFetchingArticlesState,
        );
      },
    );
  }
}

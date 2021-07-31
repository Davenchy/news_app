import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/app_cubit.dart';
import 'package:news_app/widgets/articles_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search...',
            contentPadding: const EdgeInsets.all(20),
            suffixIcon: IconButton(
              onPressed: () => _controller.clear(),
              icon: const Icon(Icons.clear),
            ),
          ),
          onFieldSubmitted: (_) => _search(),
        ),
        actions: [
          IconButton(
            onPressed: _search,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<AppCubit, AppState>(
        buildWhen: (p, c) =>
            c is AppFetchingArticlesState ||
            c is AppViewArticlesState ||
            c is AppFetchErrorResponseState,
        builder: (context, state) {
          final cubit = AppCubit.of(context);
          return ArticleList(
            articles: cubit.searchArticles,
            onRefresh: _search,
            noArticles: Center(
              child: Text(
                'No Results',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _search() {
    final String query = _controller.text;
    return AppCubit.of(context).fetchArticles(query);
  }

  @override
  void dispose() {
    AppCubit.of(context).clearSearchResults();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}

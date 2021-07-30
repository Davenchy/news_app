import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/themes.dart';
import 'package:news_app/cubits/app_cubit.dart';
import 'package:news_app/screens/layouts/home_layout.dart';
import 'package:news_app/services/news_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: BlocProvider(
        create: (_) {
          final NewsService service = NewsService.create();
          final cubit = AppCubit(service);
          cubit.fetchTechArticles();
          cubit.fetchSciArticles();
          cubit.fetchHealthArticles();
          return cubit;
        },
        child: HomeLayout(),
      ),
    );
  }
}

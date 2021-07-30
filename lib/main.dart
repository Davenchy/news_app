import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/themes.dart';
import 'package:news_app/cubits/app_cubit.dart';
import 'package:news_app/cubits/theme_cubit.dart';
import 'package:news_app/screens/layouts/home_layout.dart';
import 'package:news_app/services/news_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) {
          final NewsService service = NewsService.create();
          final cubit = AppCubit(service);
          cubit.fetchTechArticles();
          cubit.fetchSciArticles();
          cubit.fetchHealthArticles();
          return cubit;
        }),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'News App',
            debugShowCheckedModeBanner: false,
            theme: buildLightTheme(context),
            darkTheme: buildDarkTheme(context),
            themeMode: ThemeCubit.isDarkModeOf(context)
                ? ThemeMode.dark
                : ThemeMode.light,
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
        },
      ),
    );
  }
}

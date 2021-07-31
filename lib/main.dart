import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/themes.dart';
import 'package:news_app/cubits/app_cubit.dart';
import 'package:news_app/cubits/theme_cubit.dart';
import 'package:news_app/screens/layouts/home_layout.dart';
import 'package:news_app/services/news_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeCubit.loadSystemDarkModeState();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = buildLightTheme();
    final ThemeData darkTheme = buildDarkTheme();

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
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeCubit.isDarkModeOf(context)
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const HomeLayout(),
          );
        },
      ),
    );
  }
}

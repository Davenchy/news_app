import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/app_cubit.dart';
import 'package:news_app/cubits/theme_cubit.dart';
import 'package:news_app/screens/search_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
                fullscreenDialog: true,
              ),
            ),
            icon: const Icon(Icons.search),
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () => ThemeCubit.toggleDarkModeOf(context),
                icon: (state as ThemeAppliedState).isDarkMode
                    ? const Icon(
                        Icons.light_mode_rounded,
                        color: Colors.amber,
                      )
                    : const Icon(Icons.dark_mode_rounded),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<AppCubit, AppState>(
        buildWhen: (p, current) => current is AppChangedScreenState,
        builder: (context, state) {
          final cubit = context.read<AppCubit>();
          return BottomNavigationBar(
            items: cubit.screens
                .map<BottomNavigationBarItem>(
                  (e) => e.toBottomNavigationBarItem(),
                )
                .toList(),
            currentIndex: cubit.selectedScreenIndex,
            onTap: cubit.selectScreen,
          );
        },
      ),
      body: BlocBuilder<AppCubit, AppState>(
        buildWhen: (_, current) => current is AppChangedScreenState,
        builder: (context, state) => context.read<AppCubit>().currentScreen,
      ),
    );
  }
}

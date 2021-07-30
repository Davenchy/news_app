import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/app_cubit.dart';
import 'package:news_app/cubits/theme_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => ThemeCubit.toggleDarkModeOf(context),
            icon: Icon(
              Icons.light_mode,
              color: Colors.amber,
            ),
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

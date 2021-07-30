import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/app_cubit.dart';
import 'package:news_app/screens/technology_screen.dart';

class HomeLayout extends StatelessWidget {
  // TODO: add const
  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        brightness: Brightness.dark,
        actions: [
          IconButton(
            onPressed: () => null,
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => null,
            icon: Icon(Icons.settings),
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

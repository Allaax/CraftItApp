import 'package:craft_it/app.dart';
import 'package:craft_it/bloc/cubit/bottom_nav_bar_cubit.dart';
import 'package:craft_it/core/theme/app_theme.dart';
import 'package:craft_it/core/theme/theme_cubit.dart';
import 'package:craft_it/presentation/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavBarCubit>(
          create: (context) => BottomNavBarCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            locale: const Locale('ar'),
            title: 'Craft It App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode, // This listens to the current theme
            home: MainLayout(),   // Main screen with the navigation bar
          );
        },
      ),
    );
  }
}

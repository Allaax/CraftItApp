import 'package:craft_it/app.dart';
import 'package:craft_it/bloc/cubit/bottom_nav_bar_cubit.dart';
import 'package:craft_it/core/theme/app_theme.dart';
import 'package:craft_it/core/theme/theme_cubit.dart';
import 'package:craft_it/presentation/login_screen.dart';
import 'package:craft_it/presentation/cutomer_side/main_layout.dart';
import 'package:craft_it/presentation/storehome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cubit/auth_cubit.dart';
import 'bloc/state/auth_state.dart';
import 'core/network/dio_client.dart';
import 'data/repo/auth_repo.dart';
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
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(AuthRepository()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            locale: const Locale('ar'),
            title: 'Craft It App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                // Check the authentication state
                if (authState is AuthLoading) {
                  print('loading');
                  return const Center(child: CircularProgressIndicator()); // Show a loading indicator
                } else if (authState is AuthLoggedIn) {
                  return authState.user.role == 'customer' ? const MainLayout() : const Store(); // Replace with your actual home screen based on role
                } else {
                  print("login");
                  return LoginScreen(); // Replace with your actual login screen
                }
              },
            ),
          );
        },
      ),
    );
  }
}
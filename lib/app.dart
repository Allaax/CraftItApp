import 'package:craft_it/app.dart';
import 'package:craft_it/core/theme/app_theme.dart';
import 'package:craft_it/core/theme/theme_cubit.dart';
import 'package:craft_it/presentation/main_layout.dart';
import 'package:craft_it/presentation/navigation_screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (contrxt) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (BuildContext context, ThemeMode state) {
              return  MaterialApp(
                locale: const Locale('ar'),
                title: 'Craft It App',
                theme: AppTheme.lightTheme,
                darkTheme:  AppTheme.darkTheme,
                themeMode: state,
                home: MainLayout(),
              );
            }
        ));
  }
}

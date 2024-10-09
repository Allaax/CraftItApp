import 'package:craft_it/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: AppColors.lightText
      ),
          ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightText,

    ),
    cardColor: AppColors.cardsBackgroundLight,



  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: TextTheme(
      titleLarge: TextStyle(
          color: AppColors.darkText
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.darkText
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary,
    ),

    cardColor: AppColors.cardsBackgroundDark,



  );

}
import 'package:craft_it/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: _buildTextTheme(Brightness.light),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary, // Ensures text color matches the button color
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.lightText, // Text color for light mode buttons
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardsBackgroundLight,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
      labelStyle: TextStyle(color: AppColors.lightText),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.lightGrey,
      backgroundColor: AppColors.cardsBackgroundLight,
    ),
    cardColor: AppColors.cardsBackgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      foregroundColor: AppColors.lightText,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: _buildTextTheme(Brightness.dark),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.darkText, // Text color for dark mode buttons
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardsBackgroundDark,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
      labelStyle: TextStyle(color: AppColors.darkText),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.darkGrey,
      backgroundColor: AppColors.cardsBackgroundDark,
    ),
    cardColor: AppColors.cardsBackgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkText,
      elevation: 0,
    ),
  );

  static TextTheme _buildTextTheme(Brightness brightness) {
    final Color textColor = (brightness == Brightness.light)
        ? AppColors.lightText
        : AppColors.darkText;

    return TextTheme(
      titleLarge: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: textColor.withOpacity(0.7),
        fontSize: 14,
      ),
      button: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    cardTheme: const CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: AppColors.kPrimaryColor,
      unselectedItemColor: Colors.blueGrey,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    cardTheme: const CardThemeData(
      color: Colors.black,
      surfaceTintColor: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: AppColors.kPrimaryColor,
      unselectedItemColor: Colors.blueGrey,
    ),
  );
}
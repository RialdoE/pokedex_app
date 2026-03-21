import 'package:flutter/material.dart';

class AppColors {
  //Core Colors
  static const pokemonRed = Color(0xFFCC0000);
  static const pokemonWhite = Color(0xFFFFFFFF);
  static const pokemonYellow = Color(0xFFFFCB05);
  static const pokemonGrey = Color(0xFF333333);

  // Light mode colors
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xFFF5F5F5);
  static const lightInputFill = Color(0xFFD0D0D0);
  static const lightBorder = Color(0xFFE0E0E0);
  static const lightTextPrimary = Color(0xFF333333);
  static const lightSwitchTrack = Color(0xFFFFFFFF);
  static const lightSwitchThumb = Color(0xFFCCCCCC);

  // Dark mode colors
  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkInputFill = Color(0xFF2A2A2A);
  static const darkBorder = Color(0xFF444444);
  static const darkTextPrimary = Color(0xFFEEEEEE);
  static const darkSwitchTrack = Color(0xFF555555);
}

class AppTheme {

  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.pokemonRed,
    colorScheme: const ColorScheme.light(
      primary: AppColors.pokemonRed,
      secondary: AppColors.pokemonYellow,
      surface: AppColors.lightSurface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.pokemonRed,
      foregroundColor: AppColors.pokemonWhite,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pokemonRed,
        foregroundColor: AppColors.pokemonWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightInputFill,
      labelStyle: const TextStyle(color: AppColors.lightTextPrimary),
      hintStyle: const TextStyle(color: AppColors.lightTextPrimary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.pokemonRed, width: 2),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
        ? AppColors.pokemonRed
        : AppColors.lightSwitchThumb,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
        ? AppColors.pokemonRed.withValues(alpha: 0.4)
        : AppColors.lightSwitchTrack,
      ),
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
        ? Colors.transparent
        : AppColors.lightSwitchThumb,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightTextPrimary),
      bodyMedium: TextStyle(color: AppColors.lightTextPrimary),
      titleLarge: TextStyle(color: AppColors.lightTextPrimary, fontWeight: FontWeight.bold),
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.pokemonRed,
    colorScheme: ColorScheme.dark(
      primary: AppColors.pokemonRed,
      secondary: AppColors.pokemonYellow,
      surface: AppColors.darkSurface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.pokemonRed,
      foregroundColor: AppColors.pokemonWhite,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pokemonRed,
        foregroundColor: AppColors.pokemonWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkBorder,
      labelStyle: const TextStyle(color: AppColors.pokemonWhite),
      hintStyle: const TextStyle(color: AppColors.pokemonGrey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.pokemonRed, width: 2),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
        ? AppColors.pokemonRed
        : AppColors.darkSwitchTrack,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
        ? AppColors.pokemonRed.withValues(alpha: 0.4)
        : AppColors.darkSwitchTrack,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(color: AppColors.darkTextPrimary),
      titleLarge: TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.bold),
    ),
  );
}
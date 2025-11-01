import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/presentation/themes/font_app.dart';

class ThemeApp {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: FontApp.displayLarge,
      displayMedium: FontApp.displayMedium,
      displaySmall: FontApp.displaySmall,
      headlineLarge: FontApp.headlineLarge,
      headlineMedium: FontApp.headlineMedium,
      headlineSmall: FontApp.headlineSmall,
      titleLarge: FontApp.titleLarge,
      titleMedium: FontApp.titleMedium,
      titleSmall: FontApp.titleSmall,
      bodyLarge: FontApp.bodyLarge,
      bodyMedium: FontApp.bodyMedium,
      bodySmall: FontApp.bodySmall,
      labelLarge: FontApp.labelLarge,
      labelMedium: FontApp.labelMedium,
      labelSmall: FontApp.labelSmall,
    );
  }

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3E5F90),
      brightness: Brightness.light,
    ),
    textTheme: _textTheme,
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3E5F90),
      brightness: Brightness.dark,
    ),
    textTheme: _textTheme,
    useMaterial3: true,
  );
}
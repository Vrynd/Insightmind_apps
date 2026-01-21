import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Notifier untuk mengelola state theme mode
class ThemeModeNotifier extends Notifier<ThemeMode> {
  ThemeModeNotifier() {
    _loadThemeMode();
  }

  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

/// Memuat theme mode dari Hive storage
  Future<void> _loadThemeMode() async {
    try {
      final box = await Hive.openBox('settings');
      final themeModeString = box.get('themeMode', defaultValue: 'system');
      state = _themeModeFromString(themeModeString);
    } catch (e) {
      state = ThemeMode.system;
    }
  }

  /// Mengubah theme mode dan menyimpannya ke storage
  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = themeMode;
    try {
      final box = await Hive.openBox('settings');
      await box.put('themeMode', _themeModeToString(themeMode));
    } catch (e) {
      debugPrint('Error saving theme mode: $e');
    }
  }

  /// Toggle antara light dan dark mode
  Future<void> toggleTheme() async {
    if (state == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else if (state == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      // Jika system, set ke dark
      await setThemeMode(ThemeMode.dark);
    }
  }

  /// Konversi ThemeMode ke String
  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  /// Konversi String ke ThemeMode
  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Cek apakah sedang dalam dark mode
  bool get isDarkMode => state == ThemeMode.dark;

  /// Cek apakah sedang dalam light mode
  bool get isLightMode => state == ThemeMode.light;

  /// Cek apakah mengikuti system
  bool get isSystemMode => state == ThemeMode.system;
}

/// Provider untuk theme mode
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(() {
  return ThemeModeNotifier();
});

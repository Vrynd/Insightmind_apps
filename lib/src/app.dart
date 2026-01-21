import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/theme_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/login_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/themes/theme_app.dart';

class InsightMindApp extends ConsumerWidget {
  const InsightMindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'InsightMind',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      home: const LoginScreen(),
    );
  }
}

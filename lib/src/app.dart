import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/presentation/pages/home_pages.dart';
import 'package:insightmind_app/features/insightmind/presentation/themes/theme_app.dart';

class InsightMindApp extends StatelessWidget {
  const InsightMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InsightMind',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      home: const HomePage(),
    );
  }
}

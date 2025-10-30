import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insightmind_app/features/insightmind/presentation/pages/home_pages.dart';

class InsightMindApp extends StatelessWidget {
  const InsightMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF3E5F90);

    return MaterialApp(
      title: 'InsightMind',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.manropeTextTheme(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.manropeTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
      ),
      home: const HomePage(),
    );
  }
}

import 'package:flutter/material.dart';

class HeaderApp extends StatelessWidget {
  final TextTheme textStyle;
  final ColorScheme color;

  const HeaderApp({super.key, required this.textStyle, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Yuk, Kenali Diri!',
          style: textStyle.headlineMedium?.copyWith(
            color: color.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Cukup beberapa langkah sederhana untuk tahu\nbagaimana kabar mentalmu hari ini.',
          style: textStyle.titleMedium?.copyWith(
            color: color.onSurface,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

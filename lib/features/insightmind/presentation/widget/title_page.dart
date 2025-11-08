import 'package:flutter/material.dart';

class TitlePage extends StatelessWidget {
  final TextTheme textStyle;
  final ColorScheme color;
  final String title;

  const TitlePage({
    super.key,
    required this.textStyle,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle.headlineMedium?.copyWith(
        color: color.onSurfaceVariant,
        fontWeight: FontWeight.w600,
        height: 1.1,
      ),
    );
  }
}

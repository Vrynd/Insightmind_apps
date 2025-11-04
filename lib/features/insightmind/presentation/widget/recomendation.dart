import 'package:flutter/material.dart';

class Recomendation extends StatelessWidget {
  const Recomendation({
    super.key,
    required this.color,
    required this.textStyle,
    required this.recommendation,
  });

  final ColorScheme color;
  final TextTheme textStyle;
  final String recommendation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.insights_outlined, color: color.tertiary, size: 22),
              const SizedBox(width: 12),
              Text(
                'Rekomendasi',
                style: textStyle.titleMedium?.copyWith(
                  color: color.outline,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.primaryContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.inversePrimary, width: 1.1),
            ),
            child: Text(
              recommendation,
              style: textStyle.bodyLarge?.copyWith(color: color.secondary),
              textAlign: TextAlign.start,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}

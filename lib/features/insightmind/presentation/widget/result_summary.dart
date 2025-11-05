import 'package:flutter/material.dart';

class ResultSummary extends StatelessWidget {
  final int score;
  final String riskLevel;
  final Color riskColor;
  final ColorScheme color;
  final TextTheme textStyle;

  const ResultSummary({
    super.key,
    required this.score,
    required this.riskLevel,
    required this.riskColor,
    required this.color,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: color.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Total Skor',
                      style: textStyle.bodyLarge?.copyWith(
                        color: color.outline,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    Icon(
                      Icons.assessment_outlined,
                      color: color.secondary,
                      size: 21,
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                Text(
                  '$score',
                  style: textStyle.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    height: 1.2,
                    color: color.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),

        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: color.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Tingkat Risiko',
                      style: textStyle.bodyLarge?.copyWith(
                        color: color.outline,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    Icon(
                      Icons.health_and_safety_outlined,
                      color: riskColor,
                      size: 21,
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                Text(
                  riskLevel,
                  style: textStyle.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    height: 1.2,
                    color: color.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class IndicatorProggres extends StatelessWidget {
  final double progressValue;
  final int answeredCount;
  final int totalCount;
  final String title;
  final ColorScheme color;
  final TextTheme textStyle;

  const IndicatorProggres({
    super.key,
    required this.progressValue,
    required this.answeredCount,
    required this.totalCount,
    required this.color,
    required this.title,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Judul Progres
          Text(
            title,
            style: textStyle.titleMedium?.copyWith(
              color: color.outline.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
              height: 1.3,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: color.surfaceContainerHigh.withValues(alpha: .5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Persentase Progres
                Text(
                  "${(progressValue * 100).toInt()}%",
                  style: textStyle.titleLarge?.copyWith(
                    color: color.primary,
                    height: 1.2,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 8),

                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Container(
                        height: 14,
                        decoration: BoxDecoration(
                          color: color.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            height: 14,
                            width:
                                constraints.maxWidth *
                                progressValue.clamp(0.0, 1.0),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF3E5F90), Color(0xFF5D8AA8)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Jumlah pertanyaan yang dijawab
                Text(
                  "$answeredCount dari $totalCount Pertanyaan",
                  style: textStyle.titleSmall?.copyWith(
                    color: color.outline,
                    height: 1.3,
                    fontSize: 17.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

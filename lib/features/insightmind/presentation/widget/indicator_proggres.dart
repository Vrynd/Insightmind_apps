import 'package:flutter/material.dart';

class IndicatorProggres extends StatelessWidget {
  final double progressValue;
  final int answeredCount;
  final int totalCount;
  final ColorScheme color;
  final TextTheme textStyle;

  const IndicatorProggres({
    super.key,
    required this.progressValue,
    required this.answeredCount,
    required this.totalCount,
    required this.color,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = answeredCount == 0;
    final bool isComplete = answeredCount == totalCount && totalCount > 0;

    String message;
    if (isEmpty) {
      message = "Mulailah untuk Melihat Progres Anda";
    } else if (isComplete) {
      message = "Selesai! Semua Pertanyaan Telah dijawab";
    } else {
      message = "$answeredCount dari $totalCount Sudah dijawab";
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Progres Anda',
            style: textStyle.titleSmall?.copyWith(
              color: color.outlineVariant,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            message,
            style: textStyle.titleMedium?.copyWith(
              color: color.primary,
              fontWeight: FontWeight.w600,
              fontSize: 19,
              height: 1.3
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: color.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                if (!isEmpty)
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
        ],
      ),
    );
  }
}

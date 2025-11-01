import 'package:flutter/material.dart';

class AnswerSummary extends StatelessWidget {
  final List<int> answeredScores;
  final int totalScore;
  final bool isComplete;
  final ColorScheme color;
  final TextTheme textStyle;

  const AnswerSummary({
    super.key,
    required this.answeredScores,
    required this.totalScore,
    required this.isComplete,
    required this.color,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jawaban Anda',
                style: textStyle.titleMedium?.copyWith(
                  color: color.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2.5,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ...answeredScores.asMap().entries.map((entry) {
                    final index = entry.key;
                    final score = entry.value;
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: color.inversePrimary,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Q${index + 1}: $score',
                        style: TextStyle(
                          color: color.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }),
                  if (isComplete)
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Skor: $totalScore',
                        style: TextStyle(
                          color: color.surface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

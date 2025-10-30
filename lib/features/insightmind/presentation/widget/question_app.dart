import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/domain/entities/question.dart';

class QuestionApp extends StatelessWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final Question question;
  final int? selectedScore;
  final ValueChanged<int> onChanged;

  const QuestionApp({
    super.key,
    required this.color,
    required this.textStyle,
    required this.question,
    required this.selectedScore,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAnswered = selectedScore != null;

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  question.text,
                  style: textStyle.titleMedium?.copyWith(
                    color: color.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5
                  ),
                ),
              ),
              const SizedBox(width: 6),
              if (isAnswered)
                Icon(Icons.check_circle, color: color.primary, size: 20),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: color.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.outlineVariant, width: 1.3),
            ),
            child: Column(
              children: [
                for (int i = 0; i < question.options.length; i++) ...[
                  RadioListTile<int>(
                    value: question.options[i].score,
                    groupValue: selectedScore,
                    onChanged: (int? newScore) {
                      if (newScore != null) onChanged(newScore);
                    },
                    dense: true,
                    visualDensity: const VisualDensity(horizontal: -4),
                    contentPadding: EdgeInsets.zero,
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return color.primary;
                      }
                      return color.outline;
                    }),
                    title: Text(
                      question.options[i].label,
                      style: textStyle.bodyLarge?.copyWith(
                        color: question.options[i].score == selectedScore
                            ? color.onSurface
                            : color.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (i != question.options.length - 1)
                    Divider(
                      height: 0,
                      thickness: 1,
                      color: color.outlineVariant,
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

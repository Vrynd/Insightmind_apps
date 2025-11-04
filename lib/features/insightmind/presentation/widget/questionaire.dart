import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/domain/entities/question.dart';

class Questionnaire extends StatelessWidget {
  final int index;
  final ColorScheme color;
  final TextTheme textStyle;
  final Question question;
  final int? selectedScore;
  final ValueChanged<int> onChanged;

  const Questionnaire({
    super.key,
    required this.index,
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
              Text(
                '$index. ',
                style: textStyle.titleMedium?.copyWith(
                  color: color.onSurfaceVariant,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  question.text,
                  style: textStyle.titleMedium?.copyWith(
                    color: color.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (isAnswered)
                Icon(Icons.check_circle, color: color.primary, size: 19),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            decoration: BoxDecoration(
              color: color.surfaceContainerHigh.withValues(alpha: .5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color.outlineVariant.withValues(alpha: 0.3),
                width: 1.2,
              ),
            ),
            child: Column(
              children: [
                for (int i = 0; i < question.options.length; i++) ...[
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => onChanged(question.options[i].score),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1.5,
                        horizontal: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale: 1.0,
                            child: Radio<int>(
                              value: question.options[i].score,
                              groupValue: selectedScore,
                              onChanged: (int? newScore) {
                                if (newScore != null) onChanged(newScore);
                              },
                              fillColor: WidgetStateProperty.resolveWith((
                                states,
                              ) {
                                if (states.contains(WidgetState.selected)) {
                                  return color.primary;
                                }
                                return color.outline.withValues(alpha: .5);
                              }),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              question.options[i].label,
                              style: textStyle.bodyLarge?.copyWith(
                                fontSize: 17,
                                color:
                                    question.options[i].score == selectedScore
                                    ? color.outline
                                    : color.outline,
                                fontWeight:
                                    question.options[i].score == selectedScore
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (i != question.options.length - 1)
                    Divider(
                      height: 0,
                      thickness: 1,
                      color: color.outlineVariant.withValues(alpha: 0.3),
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

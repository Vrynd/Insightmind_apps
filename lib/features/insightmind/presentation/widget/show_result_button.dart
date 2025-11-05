import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/pages/result_pages.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/score_provider.dart';

class ShowResultButton extends ConsumerWidget {
  final bool isComplete;
  final ColorScheme color;
  final TextTheme textStyle;
  final dynamic questionnaireState;

  const ShowResultButton({
    super.key,
    required this.isComplete,
    required this.color,
    required this.textStyle,
    required this.questionnaireState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 4,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 48)),
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return color.surfaceContainerHigh.withValues(alpha: 0.8);
            }
            return color.primary;
          }),
        ),
        onPressed: isComplete
            ? () {
                final answerOrdered = <int>[];
                final sortedKeys = questionnaireState.answers.keys.toList()
                  ..sort();
                for (var key in sortedKeys) {
                  answerOrdered.add(questionnaireState.answers[key]!);
                }

                ref.read(answersProvider.notifier).state = answerOrdered;

                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ResultPage()),
                );
              }
            : null,
        child: Text(
          'Lihat Hasil',
          style: textStyle.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isComplete ? color.onPrimary : color.outlineVariant,
          ),
        ),
      ),
    );
  }
}

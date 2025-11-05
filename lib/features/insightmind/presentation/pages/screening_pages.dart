import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/questionnare_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/answer_summary.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/indicator_proggres.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/reset_progress_button.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/questionaire.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/show_result_button.dart';

class ScreeningPages extends ConsumerWidget {
  const ScreeningPages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    final questions = ref.watch(questionsProvider);
    final questionnaireState = ref.watch(questionnaireProvider);
    final questionnaireNotifier = ref.read(questionnaireProvider.notifier);

    final answeredCount = questionnaireState.answers.length;
    final totalCount = questions.length;
    final progressValue = totalCount > 0 ? answeredCount / totalCount : 0.0;

    final answeredScores = questionnaireState.answers.values.toList();
    final totalScore = questionnaireState.totalScore;
    final isComplete = questionnaireState.isComplete;

    return ScaffoldApp(
      backgroundColor: color.surface,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: color.surfaceContainerLowest,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Insight',
              style: textStyle.titleLarge?.copyWith(
                color: color.primary,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Mind',
              style: textStyle.titleLarge?.copyWith(
                color: color.secondary,
                fontSize: 26,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          children: [
            // Indicator Progress
            IndicatorProggres(
              progressValue: progressValue,
              answeredCount: answeredCount,
              totalCount: totalCount,
              color: color,
              textStyle: textStyle,
            ),
            const SizedBox(height: 16),

            // Daftar Pertanyaan
            for (int i = 0; i < questions.length; i++) ...[
              Questionnaire(
                index: i + 1,
                question: questions[i],
                color: color,
                textStyle: textStyle,
                selectedScore: questionnaireState.answers[questions[i].id],
                onChanged: (score) {
                  final firstUnansweredIndex = questions.indexWhere(
                    (q) => !questionnaireState.answers.containsKey(q.id),
                  );

                  if (firstUnansweredIndex == i) {
                    // Jika ini pertanyaan pertama yang belum dijawab, izinkan memilih jawaban
                    questionnaireNotifier.selectAnswer(
                      questionId: questions[i].id,
                      score: score,
                    );
                  } else {
                    // Menampilkan pesan ketika mencoba menjawab pertanyaan yang belum boleh dijawab
                    final questionNumber = firstUnansweredIndex + 1;
                    final message = questionNumber == 1
                        ? 'Silakan mulai dari pertanyaan pertama terlebih dahulu'
                        : 'Silakan jawab pertanyaan nomor $questionNumber terlebih dahulu';

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  }
                },
              ),
              if (i != questions.length - 1) const SizedBox(height: 16),
            ],

            // Ringkasan Jawaban
            if (answeredCount > 0)
              AnswerSummary(
                answeredScores: answeredScores,
                questions: questions,
                totalScore: totalScore,
                isComplete: isComplete,
                color: color,
                textStyle: textStyle,
              ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: color.surfaceContainerLowest,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Button Tampilkan Hasil
            ShowResultButton(
              isComplete: isComplete,
              color: color,
              textStyle: textStyle,
              questionnaireState: questionnaireState,
            ),
            const SizedBox(width: 10),

            // Button Reset Progress
            ResetProgressButton(color: color, textStyle: textStyle),
          ],
        ),
      ),
    );
  }
}

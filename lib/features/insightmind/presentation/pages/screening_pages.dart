import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/score_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/questionnare_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/pages/result_pages.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/answer_summary.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/indicator_proggres.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/questionaire.dart';

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
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Mind',
              style: textStyle.titleLarge?.copyWith(
                color: color.secondary,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.history_outlined, size: 28, color: color.outline),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                    final canAnswerAllPrev =
                        i == 0 ||
                        List.generate(i, (index) => questions[index].id).every(
                          (id) => questionnaireState.answers.containsKey(id),
                        );
                    if (canAnswerAllPrev) {
                      questionnaireNotifier.selectAnswer(
                        questionId: questions[i].id,
                        score: score,
                      );
                    } else {
                      String message;

                      if (i == 1) {
                        message =
                            'Silakan mulai dari pertanyaan pertama terlebih dahulu';
                      } else {
                        message =
                            'Silakan jawab pertanyaan nomor $i terlebih dahulu';
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            message,
                          ),
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
              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    ref.read(questionnaireProvider.notifier).reset();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Progress anda berhasil dipulihkan'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Text(
                    'Pulihkan Progress',
                    style: textStyle.bodyLarge?.copyWith(
                      color: color.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: color.surfaceContainerLowest,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all(
                    const Size(double.infinity, 48),
                  ),
                  elevation: WidgetStateProperty.all(0),
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return color.surfaceContainerHigh.withValues(alpha: 0.8);
                    }
                    return color.primary;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return color.outlineVariant.withValues(alpha: 0.9);
                    }
                    return color.onPrimary;
                  }),
                ),
                onPressed: isComplete
                    ? () {
                        final answerOrdered = <int>[];
                        final sortedKeys =
                            questionnaireState.answers.keys.toList()..sort();

                        for (var key in sortedKeys) {
                          answerOrdered.add(questionnaireState.answers[key]!);
                        }

                        ref.read(answersProvider.notifier).state =
                            answerOrdered;

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ResultPage(),
                          ),
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
            ),
          ],
        ),
      ),
    );
  }
}

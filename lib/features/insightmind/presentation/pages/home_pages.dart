import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/score_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/header_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/questionnare_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/pages/result_pages.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/question_app.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

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
      backgroundColor: color.surfaceContainerLow,
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
              // Welcome Apps
              Align(
                alignment: Alignment.center,
                child: HeaderApp(textStyle: textStyle, color: color),
              ),
              const SizedBox(height: 24),

              // Daftar Pertanyaan
              for (int i = 0; i < questions.length; i++) ...[
                QuestionApp(
                  question: questions[i],
                  color: color,
                  textStyle: textStyle,
                  selectedScore: questionnaireState.answers[questions[i].id],
                  onChanged: (score) {
                    questionnaireNotifier.selectAnswer(
                      questionId: questions[i].id,
                      score: score,
                    );
                  },
                ),
                // Jarak antar item untuk item bukan yang paling terakhir
                if (i != questions.length - 1) const SizedBox(height: 20),
              ],
              const SizedBox(height: 24),

              // Ringkasan dari Jawaban
              if (answeredCount > 0) ...[
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
                        'Ringkasan Jawaban',
                        style: textStyle.titleMedium?.copyWith(
                          color: color.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
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
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: color.surfaceContainerLowest,
        elevation: 8,
        height: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Indikator Progres Kuesioner
            Text(
              "$answeredCount/$totalCount",
              style: textStyle.titleLarge?.copyWith(
                color: color.tertiary,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progressValue,
                minHeight: 8,
                backgroundColor: color.surfaceContainerHigh,
                valueColor: AlwaysStoppedAnimation(color.tertiary),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "$answeredCount dari $totalCount pertanyaan terjawab"
                  .toUpperCase(),
              style: textStyle.bodyLarge?.copyWith(
                color: color.secondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            // Button untuk Melihat Hasil dan Menghapus Semua Jawaban
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 52),
                      backgroundColor: isComplete
                          ? color.primary
                          : color.surfaceContainerHigh,
                      elevation: 0,
                    ),
                    onPressed: isComplete
                        ? () {
                            final answerOrdered = <int>[];
                            final sortedKeys =
                                questionnaireState.answers.keys.toList()
                                  ..sort();

                            for (var key in sortedKeys) {
                              answerOrdered.add(
                                questionnaireState.answers[key]!,
                              );
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
                      'Lihat Hasil Screening'.toUpperCase(),
                      style: textStyle.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: .8,
                        color: isComplete
                            ? color.onPrimary
                            : color.outlineVariant,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(double.infinity, 52),
                      backgroundColor: color.surfaceContainerHigh,
                      elevation: 0,
                    ),
                    onPressed: () {
                      ref.read(questionnaireProvider.notifier).reset();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Kuesioner berhasil direset'),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    label: Icon(
                      Icons.refresh_outlined,
                      size: 30,
                      color: color.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

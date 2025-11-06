import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/questionnare_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/answer_summary.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/indicator_proggres.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/reset_progress_button.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/questionaire.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/show_result_button.dart';

class ScreeningScreen extends ConsumerStatefulWidget {
  const ScreeningScreen({super.key});

  @override
  ConsumerState<ScreeningScreen> createState() => _ScreeningScreenState();
}

class _ScreeningScreenState extends ConsumerState<ScreeningScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && !_isScrolling) {
        setState(() => _isScrolling = true);
      } else if (_scrollController.offset <= 0 && _isScrolling) {
        setState(() => _isScrolling = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: _isScrolling ? color.surfaceContainerLowest : color.surface,
        centerTitle: true,
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isScrolling ? 1.0 : 0.0,
          child: Text(
            'Kuesioner',
            style: textStyle.titleMedium?.copyWith(
              color: color.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              fontSize: 19,
              height: 1.2,
            ),
          ),
        ),
        leading: BackButton(
          color: color.onSurfaceVariant,
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          overscroll: false,
          physics: BouncingScrollPhysics(),
        ),
        child: ListView(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 30),
          children: [
            Text(
              'Kuesioner',
              style: textStyle.headlineMedium?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                height: 1.1
              ),
            ),
            const SizedBox(height: 10),

            IndicatorProggres(
              progressValue: progressValue,
              answeredCount: answeredCount,
              totalCount: totalCount,
              color: color,
              textStyle: textStyle,
            ),
            const SizedBox(height: 16),

            for (int i = 0; i < questions.length; i++) ...[
              Questionnaire(
                index: i + 1,
                question: questions[i],
                color: color,
                textStyle: textStyle,
                selectedScore: questionnaireState.answers[questions[i].id],
                onChanged: (score) {
                  final isAnswered = questionnaireState.answers.containsKey(
                    questions[i].id,
                  );

                  if (isAnswered) {
                    questionnaireNotifier.selectAnswer(
                      questionId: questions[i].id,
                      score: score,
                    );
                  } else {
                    final canAnswer =
                        i == 0 ||
                        List.generate(i, (index) => questions[index].id).every(
                          (id) => questionnaireState.answers.containsKey(id),
                        );

                    if (canAnswer) {
                      questionnaireNotifier.selectAnswer(
                        questionId: questions[i].id,
                        score: score,
                      );
                    } else {
                      final firstUnansweredIndex = questions.indexWhere(
                        (q) => !questionnaireState.answers.containsKey(q.id),
                      );
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
                  }
                },
              ),
              if (i != questions.length - 1) const SizedBox(height: 16),
            ],

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
          children: [
            ShowResultButton(
              isComplete: isComplete,
              color: color,
              textStyle: textStyle,
              questionnaireState: questionnaireState,
            ),
            const SizedBox(width: 10),
            ResetProgressButton(color: color, textStyle: textStyle),
          ],
        ),
      ),
    );
  }
}

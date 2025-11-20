import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/questionnare_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/score_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/result_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/alert_confirmation.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/answer_summary.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/button_action.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/indicator_proggres.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/questionaire.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';

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

  void _goToResult() {
    final questionnaireState = ref.read(questionnaireProvider);

    final sortedKeys = questionnaireState.answers.keys.toList()..sort();
    final answerOrdered = sortedKeys
        .map((key) => questionnaireState.answers[key]!)
        .toList();

    ref.read(answersProvider.notifier).state = answerOrdered;

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ResultScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    // Mengambil daftar pertanyaan dan state kuisioner dari provider
    final questions = ref.watch(questionsProvider);
    final questionnaireState = ref.watch(questionnaireProvider);
    // Digunakan untuk mengubah state kuisioner seperti reset
    final questionnaireNotifier = ref.read(questionnaireProvider.notifier);

    // Menghitung progres kuisioner sesuai dengan jumlah jawaban yang diisi
    final answeredCount = questionnaireState.answers.length;
    final totalCount = questions.length;
    final progressValue = totalCount > 0 ? answeredCount / totalCount : 0.0;

    // Ambil total skor dari semua jawaban dan cek apakah semuanya sudah dijawab
    final totalScore = questionnaireState.totalScore;
    final isComplete = questionnaireState.isComplete;
    // Cek apakah ada jawaban yang sudah diisi user
    final isAnyAnswered = questionnaireState.answers.isNotEmpty;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        if (!isAnyAnswered) {
          Navigator.of(context).pop();
          return;
        }
        final result = await showConfirmationSheet(
          context: context,
          color: color,
          textStyle: textStyle,
          icon: Icons.exit_to_app_rounded,
          iconColor: color.primary,
          iconBackground: color.primaryContainer,
          title: 'Keluar dari Kuisioner?',
          description:
              'Meninggalkan halaman ini akan menghapus semua jawaban yang sudah Anda isi. Lanjutkan keluar?',
          confirmTitle: 'Ya, Keluar',
          cancelTitle: 'Batal',
        );

        if (result == true) {
          ref.read(questionnaireProvider.notifier).reset();
          Navigator.of(context).pop();
        }
      },
      child: ScaffoldApp(
        backgroundColor: color.surface,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: _isScrolling
              ? color.surfaceContainerLowest
              : color.surface,
          centerTitle: true,
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isScrolling ? 1.0 : 0.0,
            child: Text(
              'Kuisioner Skrining',
              style: textStyle.titleMedium?.copyWith(
                color: color.onSurface,
                fontWeight: FontWeight.w600,
                height: 1.3,
                fontSize: 18.4,
              ),
            ),
          ),
          leading: BackButton(color: color.onSurface),
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            overscroll: false,
            physics: BouncingScrollPhysics(),
          ),
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.only(top: 0, left: 18, right: 18, bottom: 30),
            children: [
              // Judul Halaman yang sedang aktif
              TitlePage(
                textStyle: textStyle,
                color: color,
                title: 'Kuisioner Skrining',
              ),
              const SizedBox(height: 14),

              // Widget untuk menampilkan progres saat user mengisi kuisioner
              IndicatorProggres(
                title: 'Progres Anda',
                progressValue: progressValue,
                answeredCount: answeredCount,
                totalCount: totalCount,
                color: color,
                textStyle: textStyle,
              ),
              const SizedBox(height: 24),

              // Widget untuk menampilkan daftar pertanyaan beserta opsi jawaban
              for (int i = 0; i < questions.length; i++) ...[
                Questionnaire(
                  index: i + 1,
                  question: questions[i],
                  color: color,
                  textStyle: textStyle,
                  selectedScore: questionnaireState.answers[questions[i].id],
                  // Callback untuk memilih jawaban
                  onChanged: (score) {
                    questionnaireNotifier.selectAnswer(
                      questionId: questions[i].id,
                      score: score,
                    );
                  },
                ),
                if (i != questions.length - 1) const SizedBox(height: 18),
              ],

              // Widget yang akan menampilkan ringkasan jawaban yang sudah dijawab
              if (answeredCount > 0) ...[
                const SizedBox(height: 24),
                AnswerSummary(
                  answers: questionnaireState.answers,
                  questions: questions,
                  totalScore: totalScore,
                  isComplete: isComplete,
                  title: 'Ringkasan Jawaban',
                  color: color,
                  textStyle: textStyle,
                ),
              ],
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: color.surfaceContainerLowest,
          child: Row(
            spacing: 12,
            children: [
              // Widget untuk menampilkan menampilkan hasil dari skrining
              ButtonAction(
                color: color,
                textStyle: textStyle,
                titleAction: 'Lihat Hasil',
                enabled: isComplete,
                onPressed: isComplete ? _goToResult : null,
              ),

              // Widget untuk mereset progress pada kuisioner
              ButtonAction(
                color: color,
                textStyle: textStyle,
                buttonColor: Colors.orange.shade200,
                flex: 1,
                iconAction: Icons.refresh,
                iconActionColor: Colors.orange.shade800,
                enabled: isAnyAnswered,
                onPressed: () async {
                  final result = await showConfirmationSheet(
                    context: context,
                    color: color,
                    textStyle: textStyle,
                    icon: Icons.refresh,
                    iconColor: Colors.orange.shade800,
                    iconBackground: Colors.orange.shade100,
                    title: 'Reset Progress?',
                    description:
                        'Semua jawaban yang sudah diisi akan terhapus. Yakin ingin reset progress?',
                    confirmTitle: 'Ya, Reset',
                    cancelTitle: 'Batal',
                  );

                  if (result == true) {
                    ref.read(questionnaireProvider.notifier).reset();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

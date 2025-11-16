import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/domain/entities/question.dart';

class AnswerSummary extends StatefulWidget {
  final Map<String, int> answers;
  final List<Question> questions;
  final int totalScore;
  final bool isComplete;
  final String title;
  final ColorScheme color;
  final TextTheme textStyle;

  const AnswerSummary({
    super.key,
    required this.answers,
    required this.questions,
    required this.totalScore,
    required this.isComplete,
    required this.color,
    required this.title,
    required this.textStyle,
  });

  @override
  State<AnswerSummary> createState() => _AnswerSummaryState();
}

class _AnswerSummaryState extends State<AnswerSummary> {
  bool _isExpanded = false;
  final int _defaultSummary = 5;

  @override
  Widget build(BuildContext context) {
    final entries = widget.answers.entries.toList();
    final totalAnswers = entries.length;

    final visible = _isExpanded
        ? totalAnswers
        : totalAnswers.clamp(0, _defaultSummary);

    Color getScoreColor(int score) {
      switch (score) {
        case 0:
          return Colors.green.shade600;
        case 1:
          return Colors.amber.shade700;
        case 2:
          return Colors.deepOrange.shade400;
        case 3:
          return Colors.red.shade700;
        default:
          return widget.color.primaryContainer;
      }
    }

    Color getBackgroundColor(int score) {
      switch (score) {
        case 0:
          return Colors.green.shade50;
        case 1:
          return Colors.amber.shade100;
        case 2:
          return Colors.orange.shade100;
        case 3:
          return Colors.red.shade100;
        default:
          return widget.color.surfaceContainerHigh;
      }
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Judul Ringkasan Jawaban
          Text(
            widget.title,
            style: widget.textStyle.titleMedium?.copyWith(
              color: widget.color.outline.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
              height: 1.3,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 14),

          // Daftar ringkasan yang sudah dijawab
          ...List.generate(visible, (index) {
            final entry = entries[index];
            final questionId = entry.key;
            final score = entry.value;

            final questionIndex = widget.questions.indexWhere(
              (q) => q.id.toString() == questionId,
            );

            if (questionIndex == -1) {
              return const SizedBox.shrink();
            }

            final question = widget.questions[questionIndex];
            final selectedOption = question.options.firstWhere(
              (opt) => opt.score == score,
              orElse: () => const AnswerOption(label: '-', score: 0),
            );

            // Warna berdasarkan skor jawaban
            final baseColor = getScoreColor(score);
            final bgColor = getBackgroundColor(score);
            return Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(
                vertical: 8.8,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Teks pertanyaan (expand supaya memenuhi space)
                  Expanded(
                    child: Text(
                      'Q${questionIndex + 1}. ${selectedOption.label}',
                      style: widget.textStyle.titleSmall?.copyWith(
                        color: widget.color.onSurfaceVariant,
                        fontSize: 17.4,
                        height: 1.3,
                      ),
                    ),
                  ),

                  // Bubble skor
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: baseColor,
                    child: Text(
                      '$score',
                      style: widget.textStyle.bodyLarge?.copyWith(
                        color: widget.color.surface,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          // Tombol untuk melihat lebih banyak atau sedikit ringkasan jawaban
          if (totalAnswers > _defaultSummary)
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (!mounted) return;
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? 'Tutup' : 'Lihat Lainnya',
                style: widget.textStyle.bodyLarge?.copyWith(
                  color: widget.color.secondary,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

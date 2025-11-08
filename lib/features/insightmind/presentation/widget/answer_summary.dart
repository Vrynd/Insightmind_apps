import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/domain/entities/question.dart';

class AnswerSummary extends StatefulWidget {
  final List<int> answeredScores;
  final List<Question> questions;
  final int totalScore;
  final bool isComplete;
  final String title;
  final ColorScheme color;
  final TextTheme textStyle;

  const AnswerSummary({
    super.key,
    required this.answeredScores,
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
  final int _defaultVisibleCount = 5;

  Color _getScoreColor(int score) {
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

  Color _getBackgroundColor(int score) {
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

  @override
  Widget build(BuildContext context) {
    final totalAnswers = widget.answeredScores.length;
    final visibleCount = _isExpanded
        ? totalAnswers
        : (_defaultVisibleCount < totalAnswers
              ? _defaultVisibleCount
              : totalAnswers);

    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.color.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Judul Ringkasan Jawaban
              Text(
                widget.title,
                style: widget.textStyle.titleMedium?.copyWith(
                  color: widget.color.outline.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  fontSize: 18.8,
                ),
              ),
              const SizedBox(height: 12),

              // Daftar ringkasan yang sudah dijawab
              ...List.generate(visibleCount, (index) {
                final score = widget.answeredScores[index];
                final question = widget.questions[index];
                final selectedOption = question.options.firstWhere(
                  (opt) => opt.score == score,
                  orElse: () => const AnswerOption(label: '-', score: 0),
                );

                // Warna berdasarkan skor jawaban
                final baseColor = _getScoreColor(score);
                final bgColor = _getBackgroundColor(score);

                return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: baseColor.withValues(alpha: 0.35),
                      width: 0.9,
                    ),
                  ),
                  child: ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 16,
                    ),
                    title: Text(
                      'Q${index + 1}. ${selectedOption.label}',
                      style: widget.textStyle.bodyLarge?.copyWith(
                        color: widget.color.onSurface.withValues(alpha: 0.5),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: CircleAvatar(
                      radius: 14,
                      backgroundColor: baseColor.withValues(alpha: 0.8),
                      child: Text(
                        '$score',
                        style: widget.textStyle.bodyMedium?.copyWith(
                          color: widget.color.surface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // Tombol untuk melihat lebih banyak atau sedikit ringkasan jawaban
              if (totalAnswers > _defaultVisibleCount)
                TextButton.icon(
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: widget.color.tertiary,
                    size: 22,
                  ),
                  label: Text(
                    _isExpanded ? 'Lihat Lebih Sedikit' : 'Lihat Lainnya',
                    style: widget.textStyle.bodyLarge?.copyWith(
                      color: widget.color.tertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

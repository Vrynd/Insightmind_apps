import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HistoryItem extends StatelessWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final String month;
  final String day;
  final String mainTitle;
  final String subTitle;
  final double percent;
  final int score;

  const HistoryItem({
    super.key,
    required this.color,
    required this.textStyle,
    required this.month,
    required this.day,
    required this.mainTitle,
    required this.subTitle,
    required this.percent,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: color.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      leading: Container(
        width: 55,
        height: 64,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              month.toUpperCase(),
              style: textStyle.bodyLarge?.copyWith(
                color: color.outline.withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              day,
              style: textStyle.titleMedium?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                height: 1.2,
                fontSize: 18.8,
              ),
            ),
          ],
        ),
      ),
      title: Text(
        mainTitle,
        style: textStyle.bodyLarge?.copyWith(
          fontSize: 17,
          color: color.outline.withValues(alpha: 0.7),
          height: 1.3,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          subTitle,
          style: textStyle.titleLarge?.copyWith(
            height: 1.1,
            color: color.onSurfaceVariant,
          ),
        ),
      ),
      trailing: CircularPercentIndicator(
        radius: 24.0,
        lineWidth: 6.0,
        percent: percent,
        animation: true,
        animationDuration: 700,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: color.surfaceContainerHighest,
        progressColor: color.primaryContainer,
        center: Text(
          '$score',
          style: textStyle.bodyMedium?.copyWith(
            color: color.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

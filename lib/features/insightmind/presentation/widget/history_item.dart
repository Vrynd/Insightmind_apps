import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatelessWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final String mainTitle;
  final String subTitle;
  final double percent;
  final int score;
  final String riskLevel;
  final DateTime timestamp;
  final bool showDeleteIcon;
  final VoidCallback? onDelete;
  final bool isLatest;

  const HistoryItem({
    super.key,
    required this.color,
    required this.textStyle,
    required this.mainTitle,
    required this.subTitle,
    required this.percent,
    required this.score,
    required this.riskLevel,
    required this.timestamp,
    this.showDeleteIcon = true,
    this.isLatest = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 8,
            ),
            child: Row(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      mainTitle,
                      style: textStyle.bodyLarge?.copyWith(
                        color: color.outline,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: textStyle.titleLarge?.copyWith(
                        color: color.onSurfaceVariant,
                        height: 1.1,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),

                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "$score",
                        style: textStyle.titleLarge?.copyWith(
                          color: color.onSurfaceVariant,
                          height: 1.1,
                          fontSize: 22.8,
                        ),
                      ),
                      TextSpan(
                        text: "/27",
                        style: textStyle.bodyMedium?.copyWith(
                          color: color.outline,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            // height: 0,
            color: color.outlineVariant.withValues(alpha: 0.3),
            thickness: 1.1,
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 4,
              bottom: 16,
            ),
            child: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 18,
                      color: color.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                    Text(
                      DateFormat('d MMMM').format(timestamp),
                      style: textStyle.bodyLarge?.copyWith(
                        color: color.outline,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 18,
                      color: color.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                    Text(
                      DateFormat('HH:mm').format(timestamp),
                      style: textStyle.bodyLarge?.copyWith(
                        color: color.outline,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (isLatest)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'TERBARU',
                      style: textStyle.labelSmall?.copyWith(
                        color: color.onPrimary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                if (showDeleteIcon) ...[
                  InkWell(
                    onTap: onDelete,
                    child: Icon(
                      Icons.delete_outline_rounded,
                      size: 24,
                      color: Colors.red.shade500,
                    ),
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

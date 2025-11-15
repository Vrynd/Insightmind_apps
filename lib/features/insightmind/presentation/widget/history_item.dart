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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      mainTitle,
                      style: textStyle.bodyMedium?.copyWith(
                        color: color.outline,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                        fontSize: 14.5
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subTitle,
                      style: textStyle.titleMedium?.copyWith(
                        color: color.onSurfaceVariant,
                        height: 1.2,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
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
                        style: textStyle.bodyLarge?.copyWith(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 18,
                      color: color.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 8),
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
                const SizedBox(width: 16),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 18,
                      color: color.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 8),
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

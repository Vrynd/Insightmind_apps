import 'package:flutter/material.dart';
import 'metrics_summary.dart'; // pastikan import ResultSummary & SummaryItem

class MetricsCard extends StatelessWidget {
  final String title;
  final ColorScheme color;
  final TextTheme textStyle;
  final List<MetricsItem> value;
  final bool useHighBackground;
  final bool showListTile;
  final String? listTileTitle;
  final String? listTileSubtitle;
  final bool? capturing;
  final VoidCallback? onPressed;

  const MetricsCard({
    super.key,
    required this.title,
    required this.color,
    required this.textStyle,
    required this.value,
    this.useHighBackground = false,
    this.showListTile = false,
    this.listTileTitle,
    this.listTileSubtitle,
    this.capturing,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: color.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: color.outlineVariant.withAlpha(50), width: 1.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul Card
            Text(
              title,
              style: textStyle.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color.onSurfaceVariant,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 14),

            // ResultSummary
            MetricsSummary(color: color, textStyle: textStyle, item: value),

            // Opsional ListTile
            if (showListTile &&
                listTileTitle != null &&
                listTileSubtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  tileColor: color.surfaceContainerHigh.withAlpha(100),
                  title: Text(
                    listTileTitle!,
                    style: textStyle.titleSmall?.copyWith(
                      color: color.outline,
                      fontSize: 17,
                    ),
                  ),
                  subtitle: Text(
                    listTileSubtitle!,
                    style: textStyle.titleLarge?.copyWith(
                      fontSize: 25,
                      color: color.onSurfaceVariant,
                    ),
                  ),
                  trailing: onPressed != null
                      ? OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: capturing == true
                                  ? color.error
                                  : color.primary,
                            ),
                          ),
                          onPressed: onPressed,
                          child: Text(
                            capturing == true
                                ? 'Stop Capture'
                                : 'Start Capture',
                            style: textStyle.titleSmall?.copyWith(
                              color: capturing == true
                                  ? color.error
                                  : color.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

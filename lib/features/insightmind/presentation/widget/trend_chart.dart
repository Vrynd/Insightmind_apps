import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:insightmind_app/features/insightmind/data/local/screening_record.dart';
import 'package:intl/intl.dart';

class TrendChart extends StatelessWidget {
  final List<ScreeningRecord> records;
  final ColorScheme color;
  final TextTheme textStyle;

  const TrendChart({
    super.key,
    required this.records,
    required this.color,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (records.length < 2) {
      return _EmptyTrend(color: color, textStyle: textStyle);
    }

    final sorted = [...records]
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    final spots = List.generate(
      sorted.length,
      (i) => FlSpot(i.toDouble(), sorted[i].score.toDouble()),
    );

    // Calculate statistics
    final scores = sorted.map((r) => r.score).toList();
    final minScore = scores.reduce((a, b) => a < b ? a : b);
    final maxScore = scores.reduce((a, b) => a > b ? a : b);
    final avgScore = scores.fold(0.0, (a, b) => a + b) / scores.length;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.surfaceContainerLowest,
            color.surfaceContainerLowest.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.outlineVariant.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _StatCard(
                    label: 'Terakhir',
                    value: sorted.last.score.toStringAsFixed(1),
                    icon: Icons.show_chart,
                    color: color.primary,
                    textStyle: textStyle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    label: 'Rata-rata',
                    value: avgScore.toStringAsFixed(1),
                    icon: Icons.equalizer,
                    color: color.secondary,
                    textStyle: textStyle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    label: 'Rentang',
                    value: '${minScore.toInt()}-${maxScore.toInt()}',
                    icon: Icons.unfold_more,
                    color: color.tertiary,
                    textStyle: textStyle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Chart
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 240,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 27,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 5,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: color.outlineVariant.withValues(alpha: 0.2),
                      strokeWidth: 0.8,
                      dashArray: [5, 5],
                    ),
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        reservedSize: 35,
                        getTitlesWidget: (value, _) => Text(
                          value.toInt().toString(),
                          style: textStyle.bodySmall?.copyWith(
                            color: color.outlineVariant,
                          ),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: (sorted.length / 4)
                            .clamp(1, sorted.length)
                            .toDouble(),
                        getTitlesWidget: (value, _) {
                          final index = value.toInt();
                          if (index >= 0 && index < sorted.length) {
                            return Text(
                              DateFormat(
                                'dd/MM',
                              ).format(sorted[index].timestamp),
                              style: textStyle.bodySmall?.copyWith(
                                color: color.outlineVariant,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      curveSmoothness: 0.35,
                      preventCurveOverShooting: true,
                      color: color.primary,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                              radius: 5,
                              color: color.primary,
                              strokeWidth: 2,
                              strokeColor: color.surface,
                            ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            color.primary.withValues(alpha: 0.2),
                            color.primary.withValues(alpha: 0.02),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Footer dengan Statistics
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Screening Pertama',
                          style: textStyle.bodySmall?.copyWith(
                            color: color.outlineVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat(
                            'dd/MM/yyyy',
                          ).format(sorted.first.timestamp),
                          style: textStyle.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Screening Terakhir',
                          style: textStyle.bodySmall?.copyWith(
                            color: color.outlineVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat(
                            'dd/MM/yyyy',
                          ).format(sorted.last.timestamp),
                          style: textStyle.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final TextTheme textStyle;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: textStyle.titleSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: textStyle.bodySmall?.copyWith(
              color: color.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _EmptyTrend extends StatelessWidget {
  final ColorScheme color;
  final TextTheme textStyle;

  const _EmptyTrend({required this.color, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.surfaceContainerLowest,
            color.surfaceContainerLowest.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.outlineVariant.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.outline.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.show_chart, color: color.outline, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            'Belum cukup data',
            style: textStyle.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Lakukan minimal 2 screening untuk melihat tren',
            style: textStyle.bodyMedium?.copyWith(color: color.outlineVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

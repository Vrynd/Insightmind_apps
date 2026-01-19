import 'package:flutter/material.dart';
import 'risk_statistic.dart';

class StatisticCard extends StatelessWidget {
  final ColorScheme color;
  final TextTheme textStyle;

  final int minimal;
  final int ringan;
  final int sedang;
  final int cukupBerat;
  final int berat;

  const StatisticCard({
    super.key,
    required this.color,
    required this.textStyle,
    required this.minimal,
    required this.ringan,
    required this.sedang,
    required this.cukupBerat,
    required this.berat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: ListTile.divideTiles(
          context: context,
          color: color.outlineVariant.withAlpha(50),
          tiles: [
            RiskStatistic(
              riskLevel: 'Minimal',
              value: minimal,
              color: color,
              textStyle: textStyle,
            ),
            RiskStatistic(
              riskLevel: 'Ringan',
              value: ringan,
              color: color,
              textStyle: textStyle,
            ),
            RiskStatistic(
              riskLevel: 'Sedang',
              value: sedang,
              color: color,
              textStyle: textStyle,
            ),
            RiskStatistic(
              riskLevel: 'Cukup Berat',
              value: cukupBerat,
              color: color,
              textStyle: textStyle,
            ),
            RiskStatistic(
              riskLevel: 'Berat',
              value: berat,
              color: color,
              textStyle: textStyle,
            ),
          ],
        ).toList(),
      ),
    );
  }
}

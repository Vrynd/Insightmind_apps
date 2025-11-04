import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/domain/entities/mental_result.dart';

class ResultTile extends StatelessWidget {
  const ResultTile({
    super.key,
    required this.color,
    required this.textStyle,
    required this.result,
  });

  final ColorScheme color;
  final TextTheme textStyle;
  final MentalResult result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.psychology_alt_outlined,
              color: color.primary,
              size: 22,
            ),
            dense: true,
            title: Text(
              'Jumlah Skor Anda',
              style: textStyle.titleMedium?.copyWith(
                color: color.outline,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              '${result.score}',
              style: textStyle.titleMedium?.copyWith(
                color: color.primary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(height: 0, color: color.outlineVariant, indent: 50),
          ListTile(
            leading: Icon(
              Icons.monitor_heart_outlined,
              size: 22,
              color: result.riskLevel == 'Tinggi'
                  ? Colors.red
                  : result.riskLevel == 'Sedang'
                  ? Colors.orange
                  : Colors.green,
            ),
            dense: true,
            title: Text(
              'Tingkat Risiko',
              style: textStyle.titleMedium?.copyWith(
                color: color.outline,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              result.riskLevel,
              style: textStyle.titleMedium?.copyWith(
                color: color.primary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

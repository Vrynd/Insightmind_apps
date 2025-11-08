import 'package:flutter/material.dart';

class LastResult extends StatelessWidget {
  final int totalScore;
  final String riskLevel;
  final ColorScheme color;
  final TextTheme textStyle;

  const LastResult({
    super.key,
    required this.totalScore,
    required this.riskLevel,
    required this.color,
    required this.textStyle,
  });

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'minimal':
        return Colors.green.shade400;
      case 'ringan':
        return Colors.lightGreen.shade400;
      case 'sedang':
        return Colors.orange.shade400;
      case 'cukup berat':
        return Colors.deepOrange.shade400;
      case 'berat':
        return Colors.red.shade400;
      default:
        return color.tertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color riskColor = _getRiskColor(riskLevel);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              Icons.assessment_outlined,
              color: color.secondary,
              size: 23,
            ),
            dense: true,
            title: Text(
              'Total Score',
              style: textStyle.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.3,
                color: color.onSurfaceVariant,
              ),
            ),
            trailing: Text(
              '$totalScore',
              style: textStyle.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.3,
                fontSize: 17.5,
                color: color.secondary,
              ),
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
            indent: 58,
            color: color.surfaceContainerHigh,
          ),
          ListTile(
            leading: Icon(
              Icons.health_and_safety_outlined,
              color: riskColor,
              size: 23,
            ),
            dense: true,
            title: Text(
              'Tingkat Depresi',
              style: textStyle.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.3,
                color: color.onSurfaceVariant,
              ),
            ),
            trailing: Text(
              riskLevel,
              style: textStyle.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.3,
                fontSize: 17.5,
                color: color.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

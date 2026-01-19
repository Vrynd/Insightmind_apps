import 'package:flutter/material.dart';

class RiskStatistic extends StatelessWidget {
  final String riskLevel;
  final int value;
  final ColorScheme color;
  final TextTheme textStyle;

  const RiskStatistic({
    super.key,
    required this.riskLevel,
    required this.value,
    required this.color,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final _RiskVisual visual = _riskVisual(riskLevel, color);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: visual.color.withValues(alpha: .12),
          shape: BoxShape.circle,
        ),
        child: Icon(visual.icon, color: visual.color),
      ),
      title: Text(
        riskLevel,
        style: textStyle.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        value.toString(),
        style: textStyle.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: color.onSurface,
        ),
      ),
    );
  }
}


class _RiskVisual {
  final IconData icon;
  final Color color;

  const _RiskVisual(this.icon, this.color);
}

_RiskVisual _riskVisual(String riskLevel, ColorScheme scheme) {
  switch (riskLevel) {
    case 'Minimal':
      return _RiskVisual(
        Icons.sentiment_very_satisfied,
        Colors.green,
      );

    case 'Ringan':
      return _RiskVisual(
        Icons.sentiment_satisfied,
        Colors.lightGreen,
      );

    case 'Sedang':
      return _RiskVisual(
        Icons.sentiment_neutral,
        Colors.orange,
      );

    case 'Cukup Berat':
      return _RiskVisual(
        Icons.sentiment_dissatisfied,
        Colors.deepOrange,
      );

    case 'Berat':
      return _RiskVisual(
        Icons.sentiment_very_dissatisfied,
        Colors.red,
      );

    default:
      return _RiskVisual(
        Icons.help_outline,
        scheme.outline,
      );
  }
}

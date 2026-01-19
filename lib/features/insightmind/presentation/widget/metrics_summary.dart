import 'package:flutter/material.dart';

// Fungsi dalam menentukan warna pada icon sesuai dengan tingkat depresi dari user.
Color getRiskColor(String level, ColorScheme color) {
  switch (level.toLowerCase()) {
    case 'minimal':
      return Colors.green;
    case 'ringan':
      return Colors.lightGreen;
    case 'sedang':
      return Colors.orange;
    case 'cukup berat':
      return Colors.deepOrange;
    case 'berat':
      return Colors.red;
    default:
      // wrana default dari icon, jika tidak ada yang sesuai dari case diatas
      return color.primary;
  }
}

class MetricsSummary extends StatelessWidget {
  final String? riskLevel;
  final ColorScheme color;
  final TextTheme textStyle;
  final List<MetricsItem> item;

  const MetricsSummary({
    super.key,
    this.riskLevel,
    required this.color,
    required this.textStyle,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 14,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: item,
    );
  }
}

class MetricsItem extends StatelessWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final bool useHighBackground;

  const MetricsItem({
    super.key,
    required this.color,
    required this.textStyle,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
    this.useHighBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: useHighBackground
              ? color.surfaceContainerHigh.withValues(alpha: .4)
              : color.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.outlineVariant.withAlpha(50), width: 1.1),
        ),
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Judul & icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textStyle.titleSmall?.copyWith(
                    color: color.outline,
                    height: 1.3,
                    fontSize: 17,
                  ),
                ),
                Icon(
                  icon,
                  size: 21,
                  color: iconColor ?? color.secondary,
                ),
              ],
            ),

            // Nilai metrik
            Text(
              value,
              style: textStyle.titleLarge?.copyWith(
                fontSize: 25,
                height: 1.1,
                color: color.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SensorChart extends StatelessWidget {
  final List<double> samples;
  final Color chartColor;
  final String title;
  final ColorScheme color;
  final TextTheme textStyle;

  const SensorChart({
    super.key,
    required this.samples,
    required this.chartColor,
    required this.title,
    required this.color,
    required this.textStyle,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyle.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color.onSurfaceVariant,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: chartColor.withAlpha(20),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: chartColor.withAlpha(50)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomPaint(painter: _ChartPainter(samples, chartColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<double> samples;
  final Color color;

  _ChartPainter(this.samples, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (samples.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Normalisasi data untuk visualisasi
    double minVal = samples[0];
    double maxVal = samples[0];
    for (var s in samples) {
      if (s < minVal) minVal = s;
      if (s > maxVal) maxVal = s;
    }

    double range = maxVal - minVal;
    if (range == 0) range = 1;

    final double stepX =
        size.width / (samples.length > 1 ? samples.length - 1 : 1);

    for (int i = 0; i < samples.length; i++) {
      double x = i * stepX;
      // Membalik y karena koordinat 0,0 ada di kiri atas
      double normalizedY = (samples[i] - minVal) / range;
      double y =
          size.height - (normalizedY * size.height * 0.8 + (size.height * 0.1));

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ChartPainter oldDelegate) {
    return oldDelegate.samples != samples;
  }
}

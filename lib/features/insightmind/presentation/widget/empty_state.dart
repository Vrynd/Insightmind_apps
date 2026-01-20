import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final String? imagePath;
  final IconData? icon;
  final String mainTitle;
  final String subTitle;

  const EmptyState({
    super.key,
    required this.color,
    required this.textStyle,
    required this.mainTitle,
    required this.subTitle,
    this.imagePath,
    this.icon,
  }) : assert(
         imagePath != null || icon != null,
         'Either imagePath or icon must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath != null)
            Image.asset(imagePath!, fit: BoxFit.cover, height: 200, width: 200)
          else
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.surfaceContainerHighest,
              ),
              child: Icon(
                icon,
                size: 48,
                color: color.primary.withValues(alpha: 0.85),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            mainTitle,
            style: textStyle.titleMedium?.copyWith(
              color: color.outline,
              fontWeight: FontWeight.w600,
              height: 1.2,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: textStyle.bodyLarge?.copyWith(
              color: color.outline.withValues(alpha: 0.8),
              fontSize: 17,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

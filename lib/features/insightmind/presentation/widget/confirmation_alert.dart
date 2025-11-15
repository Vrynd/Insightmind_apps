import 'package:flutter/material.dart';

class ConfirmationAlert extends StatelessWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String message;
  final String primaryAction;
  final String secondaryAction;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;

  const ConfirmationAlert({
    super.key,
    required this.color,
    required this.textStyle,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.message,
    required this.primaryAction,
    required this.secondaryAction,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: iconBackground,
            radius: 30,
            child: Icon(icon, color: iconColor, size: 42),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: textStyle.titleLarge?.copyWith(
              color: color.onSurfaceVariant,
              height: 1.1,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textStyle.bodyLarge?.copyWith(
              color: color.outline,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed:
                      onSecondaryPressed ?? () => Navigator.pop(context, false),
                  child: Text(
                    secondaryAction,
                    style: textStyle.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color.secondary,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade500,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed:
                      onPrimaryPressed ?? () => Navigator.pop(context, true),
                  child: Text(
                    primaryAction,
                    style: textStyle.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color.onError,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

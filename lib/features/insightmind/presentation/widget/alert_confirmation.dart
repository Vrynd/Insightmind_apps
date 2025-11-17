import 'package:flutter/material.dart';

Future<bool?> showConfirmationSheet({
  required BuildContext context,
  required ColorScheme color,
  required TextTheme textStyle,
  required String title,
  required String description,
  required String confirmTitle,
  required String cancelTitle,
  required IconData icon,
  required Color iconColor,
  Color? iconBackground
}) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: color.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => AlertConfirmation(
      title: title,
      description: description,
      color: color,
      textStyle: textStyle,
      icon: icon,
      iconColor: iconColor,
      iconBackground: iconBackground,
      confirmTitle: confirmTitle,
      cancelTitle: cancelTitle,
      onConfirm: () => Navigator.of(context).pop(true),
      onCancel: () => Navigator.of(context).pop(false),
    ),
  );
}

class AlertConfirmation extends StatelessWidget {
  final String title;
  final String description;
  final ColorScheme color;
  final TextTheme textStyle;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String confirmTitle;
  final String cancelTitle;
  final IconData icon;
  final Color iconColor;
  final Color? iconBackground;

  const AlertConfirmation({
    super.key,
    required this.title,
    required this.color,
    required this.textStyle,
    required this.description,
    required this.onConfirm,
    required this.onCancel,
    required this.confirmTitle,
    required this.cancelTitle,
    required this.icon,
    required this.iconColor,
    this.iconBackground
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color.outlineVariant,
            ),
          ),

          CircleAvatar(
            backgroundColor: iconBackground ?? color.errorContainer,
            radius: 26,
            child: Center(child: Icon(icon, color: iconColor, size: 34)),
          ),
          const SizedBox(height: 14),

          Text(
            title,
            style: textStyle.titleLarge?.copyWith(
              color: color.onSurface,
              height: 1.1,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
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
                    side: BorderSide(
                      color: color.outlineVariant
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: onCancel,
                  child: Text(
                    cancelTitle,
                    style: textStyle.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color.outline,
                      height: 1.3,
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
                  onPressed: onConfirm,
                  child: Text(
                    confirmTitle,
                    style: textStyle.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color.onError,
                      height: 1.3,
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

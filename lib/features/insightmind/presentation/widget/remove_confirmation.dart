import 'package:flutter/material.dart';

class RemoveConfirmation extends StatelessWidget {
  final String title;
  final String description;
  final ColorScheme color;
  final TextTheme textStyle;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const RemoveConfirmation({
    super.key,
    required this.title,
    required this.color,
    required this.textStyle,
    required this.description,
    required this.onConfirm,
    this.onCancel,
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
            backgroundColor: color.errorContainer,
            radius: 30,
            child: Center(
              child: Icon(
                Icons.delete_forever_outlined,
                color: color.error,
                size: 42,
              ),
            ),
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
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: textStyle.bodyLarge?.copyWith(
              color: color.outline,
              fontWeight: FontWeight.w500,
              height: 1.3,
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
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    onCancel?.call();
                  },
                  child: Text(
                    'Tidak',
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
                  onPressed: onConfirm,
                  child: Text(
                    'Ya, Hapus',
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

import 'package:flutter/material.dart';

class SaveResultButton extends StatelessWidget {
  final bool saved;
  final ColorScheme color;
  final TextTheme textStyle;
  final VoidCallback onPressed;

  const SaveResultButton({
    super.key,
    required this.color,
    required this.textStyle,
    required this.saved,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            const Size(double.infinity, 48),
          ),
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return color.surfaceContainerHigh.withValues(alpha: 0.8);
            }
            return color.primary;
          }),
        ),
        onPressed: saved ? null : onPressed,
        child: Text(
          saved ? 'Tersimpan' : 'Simpan Hasil',
          style: textStyle.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: saved ? color.outlineVariant : color.onPrimary,
          ),
        ),
      ),
    );
  }
}

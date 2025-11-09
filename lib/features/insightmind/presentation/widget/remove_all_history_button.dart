import 'package:flutter/material.dart';

class RemoveAllHistoryButton extends StatelessWidget {
  final String titleAction;
  final ColorScheme color;
  final TextTheme textStyle;
  final VoidCallback onPressed;
  final bool isDisabled;

  const RemoveAllHistoryButton({
    super.key,
    required this.color,
    required this.textStyle,
    required this.titleAction,
    required this.isDisabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 48)),
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return color.surfaceContainerHigh.withValues(alpha: 0.8);
            }
            return Colors.red.shade500;
          }),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Text(
          titleAction,
          style: textStyle.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDisabled ? color.outlineVariant : color.onError,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}

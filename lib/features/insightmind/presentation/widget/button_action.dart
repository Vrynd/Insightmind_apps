import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonAction extends ConsumerWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final String titleAction;
  final VoidCallback onPressed;

  const ButtonAction({
    super.key,
    required this.color,
    required this.textStyle,
    required this.titleAction,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 4,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 48)),
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.all(color.primary),
        ),
        onPressed: onPressed,
        child: Text(
          titleAction,
          style: textStyle.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: color.onPrimary,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonAction extends ConsumerWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final String? titleAction;
  final IconData? iconAction;
  final VoidCallback? onPressed;
  final bool enabled;
  final Color? buttonColor;
  final Color? disabledButtonColor;
  final Color? titleActionColor;
  final Color? iconActionColor;
  final int flex;

  const ButtonAction({
    super.key,
    required this.color,
    required this.textStyle,
    this.titleAction,
    required this.onPressed,
    this.enabled = true,
    this.flex = 4,
    this.iconAction,
    this.buttonColor,
    this.disabledButtonColor,
    this.titleActionColor,
    this.iconActionColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool hasIcon = iconAction != null;
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 48)),
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (!enabled) {
              return disabledButtonColor ??
                  color.surfaceContainerHigh.withValues(alpha: 0.8);
            }
            return buttonColor ?? color.primary;
          }),
        ),
        onPressed: enabled ? onPressed : null,
        child: hasIcon
            ? Icon(
                iconAction,
                size: 26,
                color: enabled
                    ? (iconActionColor ?? color.onPrimary)
                    : color.outlineVariant,
              )
            : Text(
                titleAction ?? "",
                style: textStyle.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  color: enabled
                      ? (titleActionColor ?? color.onPrimary)
                      : color.outlineVariant,
                ),
              ),
      ),
    );
  }
}

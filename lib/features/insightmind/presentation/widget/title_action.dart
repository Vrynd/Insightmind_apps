import 'package:flutter/material.dart';

enum ActionType { elevated, text, none }

class TitleAction extends StatelessWidget {
  final TextTheme textStyle;
  final ColorScheme color;
  final String mainTitle;
  final String? subTitle;
  final VoidCallback? onPressed;
  final IconData? iconAction;
  final bool showAction;
  final ActionType actionType;

  const TitleAction({
    super.key,
    required this.textStyle,
    required this.color,
    required this.mainTitle,
    this.subTitle,
    this.onPressed,
    this.iconAction,
    this.showAction = true,
    this.actionType = ActionType.elevated,
  });

  @override
  Widget build(BuildContext context) {
    Widget? actionWidget;

    if (showAction) {
      switch (actionType) {
        case ActionType.elevated:
          actionWidget = ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: color.primary,
              minimumSize: const Size(0, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            ),
            onPressed: onPressed,
            label: Icon(
              iconAction ?? Icons.chevron_right,
              color: color.onPrimary,
              size: 26,
            ),
          );
          break;

        case ActionType.text:
          actionWidget = TextButton(
            onPressed: onPressed,
            child: Text(
              "Lihat semua",
              style: textStyle.bodyMedium?.copyWith(
                color: color.primary,
                fontWeight: FontWeight.w600,
                height: 1.3,
                fontSize: 15.5,
              ),
            ),
          );
          break;

        case ActionType.none:
          actionWidget = null;
          break;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainTitle,
              style: textStyle.titleLarge?.copyWith(
                color: color.onSurfaceVariant,
                height: 1.1,
                fontSize: 23,
              ),
            ),
            if (subTitle != null && subTitle!.isNotEmpty) ...[
              const SizedBox(height: 5),
              Text(
                subTitle!,
                style: textStyle.titleSmall?.copyWith(
                  color: color.outline.withValues(alpha: 0.8),
                  fontSize: 17,
                  height: 1.3,
                ),
              ),
            ],
          ],
        ),
        if (actionWidget != null) actionWidget,
      ],
    );
  }
}

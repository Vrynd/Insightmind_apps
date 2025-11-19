import 'package:flutter/material.dart';

class QuickAction extends StatelessWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final List<QuickActionItem> actions;

  const QuickAction({
    super.key,
    required this.color,
    required this.textStyle,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: actions,
    );
  }
}

class QuickActionItem extends StatefulWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final String label;
  final VoidCallback? onTap;

  const QuickActionItem({
    super.key,
    required this.color,
    required this.textStyle,
    required this.icon,
    required this.label,
    this.backgroundColor,
    this.iconColor,
    this.onTap,
  });

  @override
  State<QuickActionItem> createState() => _QuickActionItemState();
}

class _QuickActionItemState extends State<QuickActionItem> {
  // State hover dengan nilai awal false
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          // Menggunakan AnimatedContainer
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.color.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(14),

            // untuk memberikan efek klik berupa border sebesar 1.2 piksel
            border: Border.all(
              width: 1.2,
              color: _isPressed
                  ? widget.color.outlineVariant.withValues(alpha: 0.8)
                  : Colors.transparent,
            ),
          ),
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Widget untuk menampilkan icon aksi
              CircleAvatar(
                radius: 25,
                backgroundColor:
                    widget.backgroundColor ??
                    widget.color.surfaceContainerHigh.withValues(alpha: .7),
                child: Icon(
                  widget.icon,
                  size: 30,
                  color: widget.iconColor ?? widget.color.outline,
                ),
              ),

              // Widget untuk menampilkan label dari aksi yang ada
              Text(
                widget.label,
                style: widget.textStyle.bodyLarge?.copyWith(
                  color: widget.color.outline,
                  height: 1.4,
                  fontSize: 16.4,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

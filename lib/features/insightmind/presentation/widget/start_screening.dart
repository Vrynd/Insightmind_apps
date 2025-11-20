import 'package:flutter/material.dart';

class StartScreening extends StatefulWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final String mainTitle;
  final String subTitle;
  final String imagePath;
  final VoidCallback? onPressed;

  const StartScreening({
    super.key,
    required this.color,
    required this.textStyle,
    required this.mainTitle,
    required this.subTitle,
    required this.imagePath,
    this.onPressed,
  });

  @override
  State<StartScreening> createState() => _StartScreeningState();
}

class _StartScreeningState extends State<StartScreening> {
  // State untuk menyimpan status apakah card ditekan atau tidak
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        transform: Matrix4.translationValues(_isPressed ? 3 : 0, 0, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.color.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          spacing: 14,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Widget untuk menampilkan ilustrasi/gambar dari card
            Container(
              width: 68,
              height: 70,
              decoration: BoxDecoration(
                color: widget.color.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Image.asset(
                  widget.imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Widget untuk menampilkan judul pada card
                  Text(
                    widget.mainTitle,
                    style: widget.textStyle.titleMedium?.copyWith(
                      color: widget.color.onSurface,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                      fontSize: 20,
                    ),
                  ),

                  // Widget untuk menampilkan deskripsi pada card
                  Text(
                    widget.subTitle,
                    style: widget.textStyle.titleSmall?.copyWith(
                      color: widget.color.outline,
                      height: 1.3,
                      fontSize: 17,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

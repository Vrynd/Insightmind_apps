import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/questionnare_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/confirmation_alert.dart';

class ResetProgressButton extends ConsumerWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final String mainTitle;
  final String subTitle;

  const ResetProgressButton({
    super.key,
    required this.color,
    required this.textStyle,
    required this.mainTitle,
    required this.subTitle,
  });

  void _showConfirmationSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      backgroundColor: color.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ConfirmationAlert(
        color: color,
        textStyle: textStyle,
        icon: Icons.refresh_outlined,
        iconColor: color.error,
        iconBackground: color.errorContainer,
        title: mainTitle,
        message: subTitle,
        primaryAction: 'Ya, Pulihkan',
        secondaryAction: 'Tidak',
        onPrimaryPressed: () {
          ref.read(questionnaireProvider.notifier).reset();
          Navigator.of(context).pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green.shade100,
              content: Text(
                'Progress anda berhasil dipulihkan',
                style: textStyle.bodyMedium?.copyWith(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  height: 1.3,
                ),
              ),
              showCloseIcon: true,
              closeIconColor: Colors.green.shade700,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionnaireState = ref.watch(questionnaireProvider);
    final isAnyAnswered = questionnaireState.answers.isNotEmpty;

    return Expanded(
      flex: 1,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 48)),
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return color.surfaceContainerHigh.withValues(alpha: .8);
            }
            return color.errorContainer;
          }),
        ),
        onPressed: isAnyAnswered
            ? () => _showConfirmationSheet(context, ref)
            : null,
        child: Icon(
          Icons.refresh_outlined,
          size: 30,
          color: isAnyAnswered ? color.error : color.outlineVariant,
        ),
      ),
    );
  }
}

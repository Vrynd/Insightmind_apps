import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/questionnare_provider.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 0,
            left: 20,
            right: 20,
            bottom: 54,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                mainTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color.onSurfaceVariant,
                  fontSize: 24,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 8),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color.outline,
                  fontSize: 18.8,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color.surfaceContainerHigh,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        'Tidak',
                        style: textStyle.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: color.secondary,
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
                      onPressed: () {
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
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Text(
                        'Ya, Pulihkan',
                        style: textStyle.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: color.onError,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
            return color.secondaryContainer;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return color.outlineVariant.withValues(alpha: .9);
            }
            return color.secondary;
          }),
        ),
        onPressed: isAnyAnswered
            ? () => _showConfirmationSheet(context, ref)
            : null,
        child: Icon(Icons.refresh_outlined, size: 30),
      ),
    );
  }
}

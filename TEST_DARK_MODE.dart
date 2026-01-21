import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/theme_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

/// Quick test widget to verify dark mode works
class DarkModeVerificationWidget extends ConsumerWidget {
  const DarkModeVerificationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final notifier = ref.read(themeModeProvider.notifier);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🌙 Dark Mode Verification Test'),
          const SizedBox(height: 24),

          // Display current theme
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Current Theme: ${themeMode.name.toUpperCase()}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 24),

          // Test toggle switch
          const ThemeToggleSwitch(),
          const SizedBox(height: 24),

          // Test buttons
          ElevatedButton(
            onPressed: () => notifier.setThemeMode(ThemeMode.light),
            child: const Text('Set Light'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => notifier.setThemeMode(ThemeMode.dark),
            child: const Text('Set Dark'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => notifier.setThemeMode(ThemeMode.system),
            child: const Text('Set System'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => notifier.toggleTheme(),
            child: const Text('Toggle'),
          ),
          const SizedBox(height: 24),

          // Display status
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  'Is Dark Mode: ${notifier.isDarkMode}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Is Light Mode: ${notifier.isLightMode}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Is System Mode: ${notifier.isSystemMode}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

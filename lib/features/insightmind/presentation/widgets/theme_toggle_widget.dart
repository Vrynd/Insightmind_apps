import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/theme_provider.dart';

/// Widget untuk toggle dark mode dengan switch
class ThemeToggleSwitch extends ConsumerWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            platformBrightness == Brightness.dark);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.light_mode,
          color: !isDarkMode
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          size: 20,
        ),
        const SizedBox(width: 8),
        Switch(
          value: isDarkMode,
          onChanged: (value) {
            ref
                .read(themeModeProvider.notifier)
                .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
          },
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.dark_mode,
          color: isDarkMode
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          size: 20,
        ),
      ],
    );
  }
}

/// Widget untuk toggle dark mode dengan icon button
class ThemeToggleIconButton extends ConsumerWidget {
  const ThemeToggleIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            platformBrightness == Brightness.dark);

    return IconButton(
      icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      onPressed: () {
        ref.read(themeModeProvider.notifier).toggleTheme();
      },
      tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
    );
  }
}

/// Widget untuk toggle dark mode dengan list tile (cocok untuk settings)
class ThemeToggleListTile extends ConsumerWidget {
  const ThemeToggleListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final platformBrightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            platformBrightness == Brightness.dark);

    return ListTile(
      leading: Icon(
        isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: const Text('Dark Mode'),
      subtitle: Text(isDarkMode ? 'Aktif' : 'Nonaktif'),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) {
          ref
              .read(themeModeProvider.notifier)
              .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
        },
      ),
      onTap: () {
        ref.read(themeModeProvider.notifier).toggleTheme();
      },
    );
  }
}

/// Widget untuk memilih theme mode (Light, Dark, System)
class ThemeModeSelector extends ConsumerWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Tema Aplikasi',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Light Mode'),
          subtitle: const Text('Tema terang'),
          secondary: const Icon(Icons.light_mode),
          value: ThemeMode.light,
          groupValue: currentThemeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) {
              ref.read(themeModeProvider.notifier).setThemeMode(value);
            }
          },
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Dark Mode'),
          subtitle: const Text('Tema gelap'),
          secondary: const Icon(Icons.dark_mode),
          value: ThemeMode.dark,
          groupValue: currentThemeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) {
              ref.read(themeModeProvider.notifier).setThemeMode(value);
            }
          },
        ),
        RadioListTile<ThemeMode>(
          title: const Text('System'),
          subtitle: const Text('Ikuti pengaturan sistem'),
          secondary: const Icon(Icons.brightness_auto),
          value: ThemeMode.system,
          groupValue: currentThemeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) {
              ref.read(themeModeProvider.notifier).setThemeMode(value);
            }
          },
        ),
      ],
    );
  }
}

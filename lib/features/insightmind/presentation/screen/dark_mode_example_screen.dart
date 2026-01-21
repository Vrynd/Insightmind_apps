import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

/// Contoh screen sederhana untuk demo dark mode
/// Anda bisa menambahkan navigasi ke screen ini dari menu settings atau drawer
class DarkModeExampleScreen extends StatelessWidget {
  const DarkModeExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Dark Mode'),
        // Contoh 1: Toggle icon button di AppBar
        actions: const [
          ThemeToggleIconButton(),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Contoh 2: Card dengan ThemeToggleSwitch
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Toggle dengan Switch',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: ThemeToggleSwitch(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Contoh 3: ThemeToggleListTile
          Card(
            child: Column(
              children: const [
                ThemeToggleListTile(),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Contoh 4: ThemeModeSelector dengan 3 pilihan
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Pilih Mode Tema',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const ThemeModeSelector(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Contoh tampilan warna theme
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preview Warna Theme',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _ColorPreview(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _ColorBox(color: colors.primary, label: 'Primary'),
        _ColorBox(color: colors.secondary, label: 'Secondary'),
        _ColorBox(color: colors.tertiary, label: 'Tertiary'),
        _ColorBox(color: colors.surface, label: 'Surface'),
        _ColorBox(color: colors.error, label: 'Error'),
      ],
    );
  }
}

class _ColorBox extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorBox({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

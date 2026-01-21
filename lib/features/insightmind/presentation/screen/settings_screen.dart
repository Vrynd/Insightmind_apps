import 'package:flutter/material.dart';
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

/// Halaman Settings untuk menampilkan opsi dark mode
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Section Tampilan
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'TAMPILAN',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const ThemeToggleListTile(),
          const Divider(),
          
          // Atau gunakan Theme Mode Selector untuk pilihan lengkap
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const ThemeModeSelector(),
              ),
            ),
          ),
          
          // Section lainnya bisa ditambahkan di sini
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'INFORMASI',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Aplikasi'),
            subtitle: const Text('Versi 1.0.0'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigasi ke halaman tentang aplikasi
            },
          ),
        ],
      ),
    );
  }
}

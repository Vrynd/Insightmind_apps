import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/feedback_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return ScaffoldApp(
      backgroundColor: color.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: color.surface,
        title: TitlePage(textStyle: textStyle, color: color, title: 'Pengaturan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tema
            ListTile(
              leading: Icon(Icons.palette_outlined, color: color.primary),
              title: Text('Tema', style: textStyle.titleMedium),
              subtitle: Text('Ubah tampilan aplikasi', style: textStyle.bodyMedium),
              trailing: Icon(Icons.chevron_right, color: color.onSurfaceVariant),
              onTap: () {
                // TODO: Implement theme selection
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur tema akan segera hadir')),
                );
              },
            ),
            const Divider(),

            // Bahasa
            ListTile(
              leading: Icon(Icons.language_outlined, color: color.primary),
              title: Text('Bahasa', style: textStyle.titleMedium),
              subtitle: Text('Pilih bahasa aplikasi', style: textStyle.bodyMedium),
              trailing: Icon(Icons.chevron_right, color: color.onSurfaceVariant),
              onTap: () {
                // TODO: Implement language selection
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur bahasa akan segera hadir')),
                );
              },
            ),
            const Divider(),

            // Notifikasi
            ListTile(
              leading: Icon(Icons.notifications_outlined, color: color.primary),
              title: Text('Notifikasi', style: textStyle.titleMedium),
              subtitle: Text('Kelola pengaturan notifikasi', style: textStyle.bodyMedium),
              trailing: Icon(Icons.chevron_right, color: color.onSurfaceVariant),
              onTap: () {
                // TODO: Implement notification settings
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur notifikasi akan segera hadir')),
                );
              },
            ),
            const Divider(),

            // Privasi
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined, color: color.primary),
              title: Text('Privasi', style: textStyle.titleMedium),
              subtitle: Text('Kelola data dan privasi', style: textStyle.bodyMedium),
              trailing: Icon(Icons.chevron_right, color: color.onSurfaceVariant),
              onTap: () {
                // TODO: Implement privacy settings
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur privasi akan segera hadir')),
                );
              },
            ),
            const Divider(),

            // Tentang
            ListTile(
              leading: Icon(Icons.info_outlined, color: color.primary),
              title: Text('Tentang', style: textStyle.titleMedium),
              subtitle: Text('Informasi aplikasi', style: textStyle.bodyMedium),
              trailing: Icon(Icons.chevron_right, color: color.onSurfaceVariant),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'InsightMind',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2026 InsightMind Team',
                );
              },
            ),
            const Divider(),

            // Feedback
            ListTile(
              leading: Icon(Icons.feedback_outlined, color: color.primary),
              title: Text('Feedback', style: textStyle.titleMedium),
              subtitle: Text('Berikan saran dan laporan bug', style: textStyle.bodyMedium),
              trailing: Icon(Icons.chevron_right, color: color.onSurfaceVariant),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) => const FeedbackScreen()),
                );
              },
            ),
            const Divider(),

            // Reset Data
            ListTile(
              leading: Icon(Icons.restore_outlined, color: color.error),
              title: Text('Reset Data', style: textStyle.titleMedium?.copyWith(color: color.error)),
              subtitle: Text('Hapus semua data aplikasi', style: textStyle.bodyMedium),
              trailing: Icon(Icons.chevron_right, color: color.onSurfaceVariant),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Konfirmasi Reset'),
                    content: const Text('Apakah Anda yakin ingin menghapus semua data? Tindakan ini tidak dapat dibatalkan.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement data reset
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Fitur reset data akan segera hadir')),
                          );
                        },
                        child: Text('Reset', style: TextStyle(color: color.error)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
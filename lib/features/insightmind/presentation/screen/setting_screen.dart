import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/feedback_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/login_screen.dart';
import 'package:insightmind_app/features/insightmind/data/local/feedback_storage.dart';
import 'package:insightmind_app/features/insightmind/data/local/history_repository.dart';
import 'package:insightmind_app/features/insightmind/data/local/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';
import 'package:insightmind_app/features/insightmind/presentation/widgets/theme_toggle_widget.dart';

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
        title: TitlePage(
          textStyle: textStyle,
          color: color,
          title: 'Pengaturan',
        ),
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
              subtitle: Text(
                'Ubah tampilan aplikasi (Terang/Gelap)',
                style: textStyle.bodyMedium,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: color.onSurfaceVariant,
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: ThemeModeSelector(),
                  ),
                );
              },
            ),
            const Divider(),

            // Tentang
            ListTile(
              leading: Icon(Icons.info_outlined, color: color.primary),
              title: Text('Tentang', style: textStyle.titleMedium),
              subtitle: Text('Informasi aplikasi', style: textStyle.bodyMedium),
              trailing: Icon(
                Icons.chevron_right,
                color: color.onSurfaceVariant,
              ),
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
              subtitle: Text(
                'Berikan saran dan laporan bug',
                style: textStyle.bodyMedium,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: color.onSurfaceVariant,
              ),
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
              title: Text(
                'Reset Data',
                style: textStyle.titleMedium?.copyWith(color: color.error),
              ),
              subtitle: Text(
                'Hapus semua data aplikasi',
                style: textStyle.bodyMedium,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: color.onSurfaceVariant,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Konfirmasi Reset'),
                    content: const Text(
                      'Apakah Anda yakin ingin menghapus semua data? Tindakan ini tidak dapat dibatalkan.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Implement data reset
                          await FeedbackStorage.clearAll();
                          await HistoryRepository().clearAll();
                          await Hive.box<User>('users').clear();

                          if (context.mounted) {
                            Navigator.pop(context); // Close dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Semua data telah dihapus'),
                              ),
                            );
                            // Navigate to login and clear navigation stack
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: Text(
                          'Reset',
                          style: TextStyle(color: color.error),
                        ),
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

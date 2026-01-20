import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/history_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/button_action.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/empty_state.dart';

import 'package:insightmind_app/features/insightmind/presentation/widget/history_item.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/alert_confirmation.dart';
import 'package:insightmind_app/features/insightmind/data/local/screening_record.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;

  ColorScheme get color => Theme.of(context).colorScheme;
  TextTheme get textStyle => Theme.of(context).textTheme;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && !_isScrolling) {
        setState(() => _isScrolling = true);
      } else if (_scrollController.offset <= 0 && _isScrolling) {
        setState(() => _isScrolling = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Fungsi yang akan melakukan konfirmasi jika ingin menghapus riwayat
  Future<void> _confirmRemoveItem(
    BuildContext context,
    ScreeningRecord record,
  ) async {
    final confirmed = await showConfirmationSheet(
      context: context,
      color: color,
      textStyle: textStyle,
      icon: Icons.delete_outline_rounded,
      iconColor: color.error,
      title: "Hapus Riwayat?",
      description:
          "Apakah Anda yakin ingin menghapus riwayat ini? Tindakan ini tidak bisa dibatalkan.",
      confirmTitle: "Ya, Hapus",
      cancelTitle: "Batal",
    );

    // Jika iya, maka data akan dihapus berdasarakan id nya
    if (confirmed == true) {
      await ref.read(historyRepositoryProvider).deleteById(record.id);
      // Kemudian provider akan memperbarui datanya
      final _ = ref.refresh(historyListProvider);
    }
  }

  // Fungsi yang akan melakukan konfirmasi jika ingin menghapus semua riwayat
  Future<void> _confirmRemoveAll(BuildContext context) async {
    final confirmed = await showConfirmationSheet(
      context: context,
      color: color,
      textStyle: textStyle,
      icon: Icons.delete_outline_rounded,
      iconColor: color.error,
      title: "Hapus Semua Riwayat?",
      description:
          "Apakah Anda yakin ingin menghapus seluruh riwayat? Semua data akan hilang secara permanen.",
      confirmTitle: "Ya, Hapus",
      cancelTitle: "Batal",
    );

    // Jika iya, maka semua data akan dihapus
    if (confirmed == true) {
      await ref.read(historyRepositoryProvider).clearAll();
      // Kemudian provider akan memperbarui datanya
      final _ = ref.refresh(historyListProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil data riwayat skrining dari provider dan memantau perubahannya
    final historyAsync = ref.watch(historyListProvider);

    return ScaffoldApp(
      backgroundColor: color.surface,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: _isScrolling
            ? color.surfaceContainerLowest
            : color.surface,
        centerTitle: true,
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isScrolling ? 1.0 : 0.0,
          child: Text(
            'Riwayat Skrining',
            style: textStyle.titleMedium?.copyWith(
              color: color.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              fontSize: 19,
              height: 1.2,
            ),
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.only(
            top: 0,
            left: 18,
            right: 18,
            bottom: 30,
          ),
          children: [
            // Judul Halaman yang sedah aktif
            TitlePage(
              textStyle: textStyle,
              color: color,
              title: 'Riwayat Skrining',
            ),
            const SizedBox(height: 12),

            // Widget untuk menampilkan data riwayat skrining
            historyAsync.when(
              data: (items) {
                // Jika riwayat masih kosong, akan menampilkan widget empty history
                if (items.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 250,
                    child: EmptyState(
                      color: color,
                      textStyle: textStyle,
                      icon:Icons.receipt_long_outlined,
                      mainTitle: 'Belum Ada Riwayat',
                      subTitle:
                          'Mulai skrining pertama anda untuk melihat\nriwayat hasil di sini',
                    ),
                  );
                }

                // Jika ada, maka akan menampilkan daftar riwayat
                return Column(
                  children: items.map((r) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: HistoryItem(
                        riskLevel: r.riskLevel,
                        color: color,
                        textStyle: textStyle,
                        mainTitle: 'Tingkat Risiko',
                        subTitle: r.riskLevel,
                        percent: r.score / 27,
                        score: r.score,
                        timestamp: r.timestamp,
                        onDelete: () {
                          _confirmRemoveItem(context, r);
                        },
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Center(
                  child: Text('Terjadi kesalahan:\n$e'),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: color.surfaceContainerLowest,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Widget untuk menghapus daftar riwayat
            ButtonAction(
              color: color,
              textStyle: textStyle,
              titleAction: 'Hapus Semua Riwayat',
              buttonColor: color.errorContainer,
              titleActionColor: color.error,
              enabled: historyAsync.value?.isNotEmpty ?? false,
              onPressed: () => _confirmRemoveAll(context),
            ),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

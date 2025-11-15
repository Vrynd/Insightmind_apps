import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/history_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/empty_history.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/history_item.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/remove_all_history_button.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/remove_confirmation.dart';
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

  Future<void> _confirmRemoveItem(
    BuildContext context,
    ScreeningRecord record,
  ) async {
    final bool? confirmed = await showModalBottomSheet<bool>(
      showDragHandle: true,
      context: context,
      backgroundColor: color.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return RemoveConfirmation(
          title: "Hapus Riwayat?",
          description:
              "Apakah kamu yakin ingin menghapus riwayat ini? Tindakan ini tidak dapat dibatalkan.",
          color: color,
          textStyle: textStyle,
          onConfirm: () {
            Navigator.of(context).pop(true);
          },
        );
      },
    );

    if (confirmed == true) {
      await ref.read(historyRepositoryProvider).deleteById(record.id);
      final _ = ref.refresh(historyListProvider);
    }
  }

  Future<void> _confirmRemoveAll(BuildContext context) async {
    final bool? confirmed = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      backgroundColor: color.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return RemoveConfirmation(
          title: "Hapus Semua Riwayat?",
          description:
              "Semua data riwayat akan dihapus dan tidak dapat dikembalikan.",
          color: color,
          textStyle: textStyle,
          onConfirm: () {
            Navigator.of(context).pop(true);
          },
        );
      },
    );

    if (confirmed == true) {
      await ref.read(historyRepositoryProvider).clearAll();
      final _ = ref.refresh(historyListProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            left: 20,
            right: 20,
            bottom: 30,
          ),
          children: [
            TitlePage(
              textStyle: textStyle,
              color: color,
              title: 'Riwayat Skrining',
            ),
            const SizedBox(height: 12),

            historyAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return EmptyHistory(
                    color: color,
                    textStyle: textStyle,
                    imagePath: 'assets/image/empty_box.png',
                    mainTitle: 'Belum Ada Riwayat',
                    subTitle:
                        'Mulai skrining pertama anda untuk melihat\nriwayat hasil di sini',
                  );
                }

                return Column(
                  children: items.map((r) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: HistoryItem(
                        riskLevel: r.riskLevel,
                        color: color,
                        textStyle: textStyle,
                        mainTitle: 'Tingkat Depresi',
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: color.surfaceContainerLowest,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RemoveAllHistoryButton(
              titleAction: 'Hapus Semua Riwayat',
              color: color,
              textStyle: textStyle,
              onPressed: () => _confirmRemoveAll(context),
              isDisabled: historyAsync.value?.isEmpty ?? true,
            ),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

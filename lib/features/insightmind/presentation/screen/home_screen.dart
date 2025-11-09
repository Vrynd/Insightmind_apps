import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/domain/entities/date.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/history_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/history_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/screening_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/banner_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/empty_history.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/history_item.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/start_screening.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_action.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;

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

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final historyAsync = ref.watch(historyListProvider);

    return ScaffoldApp(
      backgroundColor: color.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: color.surface,
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isScrolling ? 1.0 : 0.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Insight',
                style: textStyle.titleLarge?.copyWith(
                  color: color.primary,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Mind',
                style: textStyle.titleLarge?.copyWith(
                  color: color.secondary,
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          overscroll: false,
          physics: const BouncingScrollPhysics(),
        ),
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
              title: 'Selamat Datang',
            ),
            const SizedBox(height: 14),

            BannerApp(imagePath: 'assets/image/banner_mental_health.png'),
            const SizedBox(height: 14),
            StartScreening(
              color: color,
              textStyle: textStyle,
              mainTitle: 'Mulai Skrining',
              subTitle:
                  'Yuk, cek kesehatan mental anda dan dapatkan insight baru!',
              imagePath: 'assets/image/mindset.png',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScreeningScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            TitleAction(
              textStyle: textStyle,
              color: color,
              mainTitle: 'Riwayat Skrining',
              subTitle: historyAsync.when(
                data: (records) => records.isNotEmpty
                    ? 'Terakhir, ${records.first.timestamp.day} '
                              '${monthName(records.first.timestamp.month)} '
                              '${records.first.timestamp.year}'
                          .toUpperCase()
                    : 'Belum ada riwayat'.toUpperCase(),
                loading: () => 'Memuat...',
                error: (_, __) => 'Gagal memuat',
              ),
              iconAction: Icons.arrow_forward,
              actionType: ActionType.elevated,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
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

                // Ambil maksimal 3 data terakhir
                final latestRecords = items.take(4).toList();

                return Column(
                  children: latestRecords.map((r) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: HistoryItem(
                        riskLevel: r.riskLevel,
                        color: color,
                        textStyle: textStyle,
                        month: shortMonthName(r.timestamp.month),
                        day: r.timestamp.day.toString(),
                        mainTitle: 'Tingkat Depresi',
                        subTitle: r.riskLevel,
                        percent: r.score / 27,
                        score: r.score,
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Gagal memuat riwayat: $e')),
            ),
          ],
        ),
      ),
    );
  }
}

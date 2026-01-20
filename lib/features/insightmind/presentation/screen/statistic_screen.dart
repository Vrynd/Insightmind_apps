import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/history_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/report_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/history_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/empty_state.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/statistic_card.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_action.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/trend_chart.dart';

class StatisticScreen extends ConsumerStatefulWidget {
  const StatisticScreen({super.key});

  @override
  ConsumerState<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends ConsumerState<StatisticScreen> {
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
            'Statistik',
            style: textStyle.titleMedium?.copyWith(
              color: color.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              fontSize: 19,
            ),
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
          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 120),
          children: [
            TitlePage(textStyle: textStyle, color: color, title: 'Statistik'),
            const SizedBox(height: 16),

            historyAsync.when(
              data: (records) {
                if (records.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 250,
                    child: Center(
                      child: EmptyState(
                        color: color,
                        textStyle: textStyle,
                        icon: Icons.insights_outlined,
                        mainTitle: 'Belum Ada Statistik',
                        subTitle:
                            'Statistik akan tersedia setelah anda melakukan \nskrining pertama kali',
                      ),
                    ),
                  );
                }

                final minimal = records
                    .where((r) => r.riskLevel == 'Minimal')
                    .length;
                final ringan = records
                    .where((r) => r.riskLevel == 'Ringan')
                    .length;
                final sedang = records
                    .where((r) => r.riskLevel == 'Sedang')
                    .length;
                final cukupBerat = records
                    .where((r) => r.riskLevel == 'Cukup Berat')
                    .length;
                final berat = records
                    .where((r) => r.riskLevel == 'Berat')
                    .length;

                final insight =
                    'Mayoritas hasil skrining berada pada tingkat risiko '
                    'minimal hingga sedang. Tetap lakukan pemantauan secara '
                    'berkala untuk menjaga kesehatan mental Anda.';

                return Column(
                  children: [
                    StatisticCard(
                      color: color,
                      textStyle: textStyle,
                      minimal: minimal,
                      ringan: ringan,
                      sedang: sedang,
                      cukupBerat: cukupBerat,
                      berat: berat,
                    ),
                    const SizedBox(height: 24),

                    TitleAction(
                      textStyle: textStyle,
                      color: color,
                      mainTitle: 'Tren Skor Skrining',
                      subTitle: 'Lihat perkembangan skor dari waktu ke waktu',
                      showAction: false,
                    ),
                    const SizedBox(height: 14),

                    TrendChart(
                      records: records,
                      color: color,
                      textStyle: textStyle,
                    ),
                    const SizedBox(height: 24),

                    // ---------- INSIGHT PANEL + ACTIONS ----------
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Insight:\n$insight',
                              style: textStyle.bodyMedium,
                            ),
                            const SizedBox(height: 12),

                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                Chip(
                                  backgroundColor: Colors.red.shade50,
                                  label: Text(
                                    'Berat: $berat',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                                Chip(
                                  backgroundColor: Colors.orange.shade50,
                                  label: Text(
                                    'Sedang: $sedang',
                                    style: const TextStyle(
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                                Chip(
                                  backgroundColor: Colors.green.shade50,
                                  label: Text(
                                    'Minimal: $minimal',
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => const HistoryScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text('Lihat Histori'),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                FilledButton.icon(
                                  icon: const Icon(Icons.picture_as_pdf),
                                  label: const Text('PDF'),
                                  onPressed: () async {
                                    final generator = ref.read(
                                      reportGeneratorProvider,
                                    );
                                    final previewer = ref.read(
                                      reportPreviewProvider,
                                    );

                                    final history = records.map((r) {
                                      return {
                                        'tanggal': r.timestamp
                                            .toString()
                                            .substring(0, 10),
                                        'score': r.score,
                                        'riskLevel': r.riskLevel,
                                      };
                                    }).toList();

                                    final pdfBytes = await generator
                                        .generateReport(
                                          username: 'User InsightMind',
                                          history: history,
                                        );

                                    await previewer.previewPdf(
                                      onLayout: (_) async => pdfBytes,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.only(top: 32),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Center(child: Text('Terjadi kesalahan:\n$e')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/domain/entities/recomendation.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/history_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/questionnare_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/score_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/history_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/navigation_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/screening_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/quick_action.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/recomendation.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/metrics_summary.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_action.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;
  bool _saved = false;

  @override
  void initState() {
    super.initState();

    // Menambahkan listener untuk mendeteksi scroll
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && !_isScrolling) {
        setState(() => _isScrolling = true);
      } else if (_scrollController.offset <= 0 && _isScrolling) {
        setState(() => _isScrolling = false);
      }
    });

    // Menjalankan listener setelah widget dibuat, untuk menyimpan riwayat secara otomatis
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_saved) {
        final result = ref.read(resultProvider);
        final repo = ref.read(historyRepositoryProvider);

        await repo.addRecord(score: result.score, riskLevel: result.riskLevel);
        final _ = ref.refresh(historyListProvider);
        _saved = true;
      }
    });
  }

  // Membersihkan listener ketika widget dihapus, agar tidak terjadi memory leak
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final result = ref.watch(resultProvider);
    final recommendation = Recommendation.getRecommendations(result.riskLevel);

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
            'Hasil Skrining',
            style: textStyle.titleMedium?.copyWith(
              color: color.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              fontSize: 19,
              height: 1.2,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),

      // Body
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.only(
            top: 0,
            left: 18,
            right: 18,
            bottom: 30,
          ),
          children: [
            // Judul Halaman
            TitlePage(
              textStyle: textStyle,
              color: color,
              title: 'Hasil Skrining',
            ),
            const SizedBox(height: 14),

            // Widget untuk menampilkan hasil dari skrining yang dilakukan
            MetricsSummary(
              riskLevel: result.riskLevel,
              color: color,
              textStyle: textStyle,
              item: [
                MetricsItem(
                  color: color,
                  textStyle: textStyle,
                  title: 'Total Skor',
                  value: '${result.score}',
                  icon: Icons.assessment_outlined,
                  iconColor: Colors.green.shade500,
                ),
                MetricsItem(
                  color: color,
                  textStyle: textStyle,
                  title: 'Tingkat Depresi',
                  value: result.riskLevel,
                  icon: Icons.health_and_safety_outlined,
                  iconColor: getRiskColor(result.riskLevel, color),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Widget untuk menampilkan rekomendasi sesuai dengan hasil skrining
            Recomendation(
              title: 'Rekomendasi',
              color: color,
              textStyle: textStyle,
              recommendation: recommendation,
            ),
            const SizedBox(height: 24),

            // Widget untuk memberikan pilihan aksi yang bisa dilakukan oleh user
            TitleAction(
              textStyle: textStyle,
              color: color,
              mainTitle: 'Aksi Cepat',
              actionType: ActionType.none,
            ),
            const SizedBox(height: 14),
            QuickAction(
              color: color,
              textStyle: textStyle,
              actions: [
                QuickActionItem(
                  color: color,
                  textStyle: textStyle,
                  icon: Icons.home_outlined,
                  label: 'Beranda',
                  onTap: () {
                    ref.invalidate(questionnaireProvider);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const NavigationScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                QuickActionItem(
                  color: color,
                  textStyle: textStyle,
                  icon: Icons.fact_check_outlined,
                  label: 'Skrining',
                  onTap: () {
                    ref.read(questionnaireProvider.notifier).reset();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ScreeningScreen(),
                      ),
                    );
                  },
                ),
                QuickActionItem(
                  color: color,
                  textStyle: textStyle,
                  icon: Icons.history_toggle_off_outlined,
                  label: 'Riwayat',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: color.surface,
        child: Center(
          child: Text(
            'Hasil Skrining diatas otomatis tersimpan sebagai riwayat',
            style: textStyle.bodyMedium?.copyWith(
              color: color.outlineVariant,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

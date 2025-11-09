import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/domain/entities/recomendation.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/history_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/questionnare_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/score_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/navigation_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/button_action.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/recomendation.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/result_summary.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';

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

    // Jalankan auto save untuk menyimpan ke riwayat skrining
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
      ),

      // Body
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.only(
            top: 0,
            left: 20,
            right: 20,
            bottom: 30,
          ),
          children: [
            Text(
              'Hasil Skrining',
              style: textStyle.headlineMedium?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 14),

            // Ringkasan hasil
            ResultSummary(
              score: result.score,
              riskLevel: result.riskLevel,
              color: color,
              textStyle: textStyle,
            ),
            const SizedBox(height: 14),

            // Rekomendasi
            Recomendation(
              color: color,
              textStyle: textStyle,
              recommendation: recommendation,
            ),
            const SizedBox(height: 24),

            // Info auto save
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: color.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Hasil skrining telah disimpan di riwayat skrining',
                      style: textStyle.bodyLarge?.copyWith(
                        color: color.outline,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                        fontSize: 17,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Tombol bawah
      bottomNavigationBar: BottomAppBar(
        color: color.surfaceContainerLowest,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonAction(
              color: color,
              textStyle: textStyle,
              titleAction: 'Kembali Ke Beranda',
              onPressed: () {
                ref.invalidate(questionnaireProvider);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const NavigationScreen()),
                  (Route<dynamic> route) =>
                      false, // hapus semua route sebelumnya
                );
              },
            ),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

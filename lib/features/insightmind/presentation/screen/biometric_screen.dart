// WEEK 6 UI: BIOMETRIC PAGE (Stateful Consumer)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/data/models/feature_vector.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/ppg_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/score_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/sensor_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/ai_result_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/button_action.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/metrics_card.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/metrics_summary.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/sensor_chart.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';

class BiometricScreen extends ConsumerStatefulWidget {
  const BiometricScreen({super.key});

  @override
  ConsumerState<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends ConsumerState<BiometricScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(ppgProvider.notifier).reset();
    });

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
    ref.read(ppgProvider.notifier).stopCapture();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch accelerometer & PPG state
    final accel = ref.watch(accelFeatureProvider);
    final ppg = ref.watch(ppgProvider);
    final score = ref.watch(scoreProvider);

    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

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
            'Cek Kondisi',
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
        behavior: const ScrollBehavior().copyWith(
          overscroll: false,
          physics: const BouncingScrollPhysics(),
        ),
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.only(
            top: 0,
            left: 18,
            right: 18,
            bottom: 30,
          ),
          children: [
            TitlePage(textStyle: textStyle, color: color, title: 'Cek Kondisi'),
            const SizedBox(height: 14),
            MetricsCard(
              title: 'Accelerometer',
              color: color,
              textStyle: textStyle,
              value: [
                MetricsItem(
                  title: 'Mean',
                  value: accel.mean.toStringAsFixed(4),
                  icon: Icons.calculate_outlined,
                  iconColor: Colors.blueAccent,
                  color: color,
                  useHighBackground: true,
                  textStyle: textStyle,
                ),
                MetricsItem(
                  title: 'Variance',
                  value: accel.variance.toStringAsFixed(4),
                  icon: Icons.stacked_line_chart_rounded,
                  iconColor: Colors.orangeAccent,
                  color: color,
                  useHighBackground: true,
                  textStyle: textStyle,
                ),
              ],
            ),
            const SizedBox(height: 14),

            MetricsCard(
              title: 'PPG via Kamera',
              color: color,
              textStyle: textStyle,
              value: [
                MetricsItem(
                  title: 'Mean Y',
                  value: ppg.mean.toStringAsFixed(6),
                  icon: Icons.calculate_outlined,
                  iconColor: Colors.blueAccent,
                  color: color,
                  useHighBackground: true,
                  textStyle: textStyle,
                ),
                MetricsItem(
                  title: 'Variance',
                  value: ppg.variance.toStringAsFixed(6),
                  icon: Icons.stacked_line_chart_rounded,
                  iconColor: Colors.orangeAccent,
                  color: color,
                  useHighBackground: true,
                  textStyle: textStyle,
                ),
              ],
              showListTile: true,
              listTileTitle: 'Samples',
              listTileSubtitle: ppg.samples.length.toString(),
              capturing: ppg.capturing,
              onPressed: () {
                if (!ppg.capturing) {
                  ref.read(ppgProvider.notifier).startCapture();
                } else {
                  ref.read(ppgProvider.notifier).stopCapture();
                }
              },
            ),
            const SizedBox(height: 14),
            SensorChart(
              title: 'Real-time Movement',
              samples: ref
                  .watch(accelerometerStreamProvider)
                  .when(
                    data: (event) => [event.x, event.y, event.z],
                    loading: () => [],
                    error: (_, __) => [],
                  ),
              chartColor: Colors.blueAccent,
              color: color,
              textStyle: textStyle,
            ),
            const SizedBox(height: 14),
            SensorChart(
              title: 'PPG Waveform',
              samples: ppg.samples,
              chartColor: Colors.redAccent,
              color: color,
              textStyle: textStyle,
            ),
            const SizedBox(height: 14),
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
              titleAction: 'Hitung Prediksi',
              buttonColor: color.primary,
              titleActionColor: color.onPrimary,
              onPressed: () {
                if (ppg.samples.length < 30) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      content: Text(
                        "Ambil minimal 30 sampel PPG terlebih dahulu",
                      ),
                    ),
                  );
                  return;
                }

                final fv = FeatureVector(
                  screeningScore: score.toDouble(),
                  activityMean: accel.mean,
                  activityVar: accel.variance,
                  ppgMean: ppg.mean,
                  ppgVar: ppg.variance,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AIResultScreen(fv: fv)),
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

// WEEK 6 UI: BIOMETRIC PAGE (Stateful Consumer)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/ppg_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/sensor_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/metrics_card.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/metrics_summary.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
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
    // Watch accelerometer & PPG state
    final accel = ref.watch(accelFeatureProvider);
    final ppg = ref.watch(ppgProvider);
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
            'Sensor & Biometrik',
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
            TitlePage(
              textStyle: textStyle,
              color: color,
              title: 'Sensor & Biometrik',
            ),
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
          ],
        ),
      ),
    );
  }
}

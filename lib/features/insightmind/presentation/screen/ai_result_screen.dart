import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/data/models/feature_vector.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/ai_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/metrics_summary.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';

class AIResultScreen extends ConsumerStatefulWidget {
  final FeatureVector fv;
  const AIResultScreen({super.key, required this.fv});

  @override
  ConsumerState<AIResultScreen> createState() => _AIResultScreenState();
}

class _AIResultScreenState extends ConsumerState<AIResultScreen> {
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
    final resultAsync = ref.watch(aiResultProvider(widget.fv));

    return Scaffold(
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
            'Hasil Prediksi',
            style: textStyle.titleMedium?.copyWith(
              color: color.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              fontSize: 19,
              height: 1.2,
            ),
          ),
        ),
        // automaticallyImplyLeading: false,
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
              title: 'Hasil Prediksi',
            ),
            const SizedBox(height: 14),

            resultAsync.when(
              data: (result) {
                final String riskLevel = result['riskLevel'];
                final int score = result['phqEquivalentScore'];
                final double confidence = result['confidence'];

                return Column(
                  children: [
                    ListTile(
                      tileColor: color.surfaceContainerLowest,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: color.outlineVariant.withAlpha(50),
                          width: 1.1,
                        ),
                      ),
                      title: Text(
                        'Tingkat Risiko',
                        style: textStyle.titleSmall?.copyWith(
                          color: color.outline,
                          height: 1.3,
                          fontSize: 17,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          riskLevel,
                          style: textStyle.titleLarge?.copyWith(
                            fontSize: 25,
                            height: 1.1,
                            color: color.onSurfaceVariant,
                          ),
                        ),
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: color.surfaceContainerLow,
                        child: Icon(
                          Icons.health_and_safety_outlined,
                          size: 26,
                          color: getRiskColor(riskLevel, color),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    MetricsSummary(
                      riskLevel: riskLevel,
                      color: color,
                      textStyle: textStyle,
                      item: [
                        MetricsItem(
                          color: color,
                          textStyle: textStyle,
                          title: 'Skor Prediksi',
                          value: score.toString(),
                          icon: Icons.analytics_outlined,
                          iconColor: Colors.green.shade500,
                        ),
                        MetricsItem(
                          color: color,
                          textStyle: textStyle,
                          title: 'Tingkat Keyakinan',
                          value: '${(confidence * 100).toStringAsFixed(1)}%',
                          icon: Icons.verified_outlined,
                          iconColor: color.primary,
                        ),
                      ],
                    ),
                  ],
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
                child: Center(child: Text('Terjadi kesalahan:\n$e')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

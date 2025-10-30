import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/score_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/recomendation_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/result_tile_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final result = ref.watch(resultProvider);

    String recommendation;
    switch (result.riskLevel) {
      case 'Tinggi':
        recommendation =
            'Pertimbangkan berbicara dengan konselor/psikolog. Kurangi beban, istirahat cukup, dan hubungi layanan kampus';
        break;
      case 'Sedang':
        recommendation =
            'Lakukan aktivitas relaksasi (napas dalam, olahraga ringan) Atur waktu, dan evaluasi beban kuliah/kerja.';
        break;
      default:
        recommendation =
            'Pertahankan kebiasaan baik. Jaga tidur, makan, dan olahraga.';
        break;
    }

    return ScaffoldApp(
      backgroundColor: color.surfaceContainerLow,
      appBar: AppBar(
        title: Text(
          'Hasil Screening',
          style: textStyle.titleMedium?.copyWith(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: color.surfaceContainerLowest,
        automaticallyImplyLeading: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ResultTileApp(color: color, textStyle: textStyle, result: result),
              const SizedBox(height: 16),
              RecomendationApp(
                color: color,
                textStyle: textStyle,
                recommendation: recommendation,
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: color.surfaceContainerLow,
        child: Center(
          child: Text(
            'Disclaimer: InsightMind bersifat edukatif, bukan alat diagnosis medis',
            style: textStyle.bodyMedium?.copyWith(
              color: color.outline,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}

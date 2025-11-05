import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/score_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/recomendation.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/result_summary.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final result = ref.watch(resultProvider);

    List<String> recommendation;
    switch (result.riskLevel) {
      case 'Tinggi':
        recommendation = [
          'Pertimbangkan berbicara dengan konselor atau psikolog profesional.',
          'Kurangi beban kegiatan yang berlebihan agar tidak kelelahan mental.',
          'Usahakan tidur cukup dan konsumsi makanan bergizi.',
          'Hubungi layanan konseling kampus atau teman tepercaya jika perlu dukungan.',
        ];
        break;
      case 'Sedang':
        recommendation = [
          'Lakukan aktivitas relaksasi seperti napas dalam atau yoga.',
          'Atur waktu antara kuliah/kerja dan istirahat dengan seimbang.',
          'Luangkan waktu untuk melakukan kegiatan yang kamu nikmati.',
          'Evaluasi sumber stres dan diskusikan dengan teman atau mentor.',
        ];
        break;
      default:
        recommendation = [
          'Pertahankan rutinitas positif seperti tidur teratur dan olahraga ringan.',
          'Jaga pola makan seimbang dan waktu istirahat cukup.',
          'Terus berinteraksi dengan lingkungan sosial yang positif.',
          'Lakukan kegiatan yang meningkatkan suasana hati secara konsisten.',
        ];
        break;
    }

    Color riskColor;
    switch (result.riskLevel.toLowerCase()) {
      case 'rendah':
        riskColor = Colors.green;
        break;
      case 'sedang':
        riskColor = Colors.orange;
        break;
      case 'tinggi':
        riskColor = Colors.red;
        break;
      default:
        riskColor = color.primary;
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
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          children: [
            // Ringkasan Hasil
            ResultSummary(
              score: result.score,
              riskLevel: result.riskLevel,
              riskColor: riskColor,
              color: color,
              textStyle: textStyle,
            ),
            const SizedBox(height: 16),

            // Rekomendasi sesuai hasil
            Recomendation(
              color: color,
              textStyle: textStyle,
              recommendation: recommendation,
            ),
          ],
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

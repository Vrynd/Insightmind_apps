import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/score_provider.dart';
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
    final result = ref.watch(resultProvider);

    List<String> recommendation;
    switch (result.riskLevel.toLowerCase()) {
      case 'minimal':
        recommendation = [
          'Pertahankan rutinitas positif seperti olahraga dan tidur cukup.',
          'Teruskan menjaga keseimbangan antara aktivitas dan waktu istirahat.',
          'Luangkan waktu untuk kegiatan yang menyenangkan dan menenangkan.',
          'Tetap jaga interaksi sosial agar suasana hati stabil.',
        ];
        break;

      case 'ringan':
        recommendation = [
          'Mulailah mengenali sumber stres ringan yang mungkin kamu alami.',
          'Lakukan aktivitas relaksasi seperti meditasi, jalan santai, atau journaling.',
          'Tetap jaga pola makan dan tidur yang teratur.',
          'Bicarakan perasaanmu dengan orang terdekat untuk meringankan beban emosional.',
        ];
        break;

      case 'sedang':
        recommendation = [
          'Lakukan aktivitas relaksasi seperti napas dalam, yoga atau meditasi.',
          'Atur waktu antara kuliah/kerja dan istirahat dengan lebih seimbang.',
          'Luangkan waktu untuk melakukan kegiatan yang kamu nikmati.',
          'Pertimbangkan berbicara dengan konselor jika merasa stres sering muncul.',
        ];
        break;

      case 'cukup berat':
        recommendation = [
          'Disarankan berkonsultasi dengan konselor atau psikolog profesional.',
          'Kurangi tekanan aktivitas yang berlebihan agar tidak kelelahan mental.',
          'Fokus pada pemulihan dengan tidur cukup dan pola makan bergizi.',
          'Carilah dukungan emosional dari teman, keluarga, atau layanan kampus.',
        ];
        break;

      case 'berat':
        recommendation = [
          'Segera hubungi tenaga profesional seperti psikolog atau psikiater.',
          'Jangan menghadapi tekanan sendirian, libatkan orang terdekat.',
          'Batasi aktivitas berat dan berikan waktu untuk pemulihan mental.',
          'Gunakan layanan konseling kampus atau hotline kesehatan mental bila diperlukan.',
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
            'Hasil',
            style: textStyle.titleMedium?.copyWith(
              color: color.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              fontSize: 19,
              height: 1.2,
            ),
          ),
        ),
      ),

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
              'Hasil',
              style: textStyle.headlineMedium?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 12),

            // Ringkasan Hasil
            ResultSummary(
              score: result.score,
              riskLevel: result.riskLevel,
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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Recomendation extends StatefulWidget {
  final String title;
  final ColorScheme color;
  final TextTheme textStyle;
  final List<String> recommendation;

  const Recomendation({
    super.key,
    required this.title,
    required this.color,
    required this.textStyle,
    required this.recommendation,
  });

  @override
  State<Recomendation> createState() => _RecomendationState();
}

class _RecomendationState extends State<Recomendation> {
  // State controller yang akan mengendalikan pageview
  final PageController _pageController = PageController();
  Timer? _autoScrollTimer;
  int _currentPage = 0; // akan menyimpan page yang aktif saat ini

  // Inisialisasi state
  @override
  void initState() {
    super.initState();

    // auto scroll akan dimulai ketika widget dibangun
    _startAutoScroll();
  }

  // Fungsi untuk memulai auto scroll pada pageview
  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      // Jika belum sampai halaman terakhir, maka pindah page berikutnya, dan jika sudah sampai halaman terakhir, maka kembali ke halaman pertama
      if (_currentPage < widget.recommendation.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  // Membebaskan timer dan page controller ketika widget dihapus, agar tidak terjadi memory leak
  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color;
    final textStyle = widget.textStyle;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Widget untuk menampilkan judul dan icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.insights_outlined,
                color: Colors.amber.shade400,
                size: 22,
              ),
              const SizedBox(width: 12),
              Text(
                widget.title,
                style: textStyle.titleMedium?.copyWith(
                  color: color.outline.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Widget untuk menampilkan daftar rekomendasi
          SizedBox(
            height: 100,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.recommendation.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                final rec = widget.recommendation[index];

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: color.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: color.inversePrimary, width: 1.1),
                  ),
                  child: Center(
                    child: Text(
                      rec,
                      style: textStyle.titleSmall?.copyWith(
                        color: color.secondary,
                        height: 1.4,
                        fontSize: 17.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),

          // Widget untuk menampilkan indikator page berupa dot
          Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.recommendation.length,
              effect: ExpandingDotsEffect(
                activeDotColor: color.primary,
                dotColor: color.outlineVariant,
                dotHeight: 9,
                dotWidth: 9,
                expansionFactor: 2.5,
                spacing: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

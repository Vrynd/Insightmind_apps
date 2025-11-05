import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Recomendation extends StatefulWidget {
  final ColorScheme color;
  final TextTheme textStyle;
  final List<String> recommendation;

  const Recomendation({
    super.key,
    required this.color,
    required this.textStyle,
    required this.recommendation,
  });

  @override
  State<Recomendation> createState() => _RecomendationState();
}

class _RecomendationState extends State<Recomendation> {
  final PageController _pageController = PageController();
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.insights_outlined, color: color.tertiary, size: 22),
              const SizedBox(width: 12),
              Text(
                'Rekomendasi',
                style: textStyle.titleMedium?.copyWith(
                  color: color.outline.withValues(alpha: 0.8),
                  height: 1.2,
                  fontSize: 18.8,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

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
                      style: textStyle.bodyLarge?.copyWith(
                        color: color.secondary,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),

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

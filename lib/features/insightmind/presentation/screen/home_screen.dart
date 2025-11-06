import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/screening_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/banner_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/last_result.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/mood_selector.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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

    return ScaffoldApp(
      backgroundColor: color.surface,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: color.surface,
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isScrolling ? 1.0 : 0.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Insight',
                style: textStyle.titleLarge?.copyWith(
                  color: color.primary,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Mind',
                style: textStyle.titleLarge?.copyWith(
                  color: color.secondary,
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
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
            left: 20,
            right: 20,
            bottom: 30,
          ),
          children: [
            Text(
              'Beranda ',
              style: textStyle.headlineMedium?.copyWith(
                color: color.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 12),

            BannerApp(imagePath: 'assets/image/banner_mental_health.png'),
            const SizedBox(height: 12),

            MoodSelector(title: 'Bagaimana harimu hari ini?'),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kondisi Terakhir',
                      style: textStyle.titleLarge?.copyWith(
                        color: color.onSurfaceVariant,
                        height: 1.1,
                        fontSize: 23,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rabu, 05 November 2025',
                      style: textStyle.titleSmall?.copyWith(
                        color: color.outline.withValues(alpha: 0.8),
                        fontSize: 16,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: color.primary,
                    minimumSize: const Size(0, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ScreeningScreen(),
                      ),
                    );
                  },
                  label: Icon(
                    Icons.arrow_forward_rounded,
                    color: color.onPrimary,
                    size: 26,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            LastResult(
              totalScore: 0,
              riskLevel: 'Tidak Ada',
              color: color,
              textStyle: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

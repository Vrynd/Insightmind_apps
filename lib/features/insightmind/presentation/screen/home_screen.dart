import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/history_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/screening_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/banner_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/empty_history.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/history_item.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/start_screening.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_action.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;

  final List<Map<String, dynamic>> historyData = [];

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
            TitlePage(
              textStyle: textStyle,
              color: color,
              title: 'Selamat Datang',
            ),
            const SizedBox(height: 14),

            BannerApp(imagePath: 'assets/image/banner_mental_health.png'),
            const SizedBox(height: 14),
            StartScreening(
              color: color,
              textStyle: textStyle,
              mainTitle: 'Mulai Skrining',
              subTitle:
                  'Yuk, cek kesehatan mental anda dan dapatkan insight baru!',
              imagePath: 'assets/image/mindset.png',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScreeningScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            TitleAction(
              textStyle: textStyle,
              color: color,
              mainTitle: 'Riwayat Skrining',
              subTitle: 'Terakhir, 08 November 2025',
              iconAction: Icons.arrow_forward,
              actionType: ActionType.elevated,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            if (historyData.isEmpty)
              EmptyHistory(
                color: color,
                textStyle: textStyle,
                imagePath: 'assets/image/empty_box.png',
                mainTitle: 'Belum Ada Riwayat',
                subTitle:
                    'Mulai skrining pertama anda untuk melihat\nriwayat hasil di sini',
              )
            else
              Column(
                children: historyData.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: HistoryItem(
                      color: color,
                      textStyle: textStyle,
                      month: item['month'],
                      day: item['day'],
                      mainTitle: item['mainTitle'],
                      subTitle: item['subTitle'],
                      percent: item['percent'],
                      score: item['score'],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

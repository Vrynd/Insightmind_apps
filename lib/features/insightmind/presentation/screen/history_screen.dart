import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/empty_history.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
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

  Color _getRiskColor(String level, ColorScheme color) {
    switch (level.toLowerCase()) {
      case 'minimal':
        return Colors.green;
      case 'ringan':
        return Colors.lightGreen;
      case 'sedang':
        return Colors.orange;
      case 'cukup berat':
        return Colors.deepOrange;
      case 'berat':
        return Colors.red;
      default:
        return color.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            'Riwayat Skrining',
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
            left: 20,
            right: 20,
            bottom: 30,
          ),
          children: [
            TitlePage(
              textStyle: textStyle,
              color: color,
              title: 'Riwayat Skrining',
            ),
            const SizedBox(height: 12),

            EmptyHistory(
              color: color,
              textStyle: textStyle,
              imagePath: 'assets/image/empty_box.png',
              mainTitle: 'Belum Ada Riwayat',
              subTitle:
                  'Lakukan skrining pertama Anda untuk\nmelihat hasil di sini',
            ),

            ListTile(
              tileColor: color.surfaceContainerLowest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              leading: Container(
                width: 55,
                height: 64,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nov'.toUpperCase(),
                      style: textStyle.bodyLarge?.copyWith(
                        color: color.outline.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '8',
                      style: textStyle.titleMedium?.copyWith(
                        color: color.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        fontSize: 18.8,
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(
                'Level Depressi',
                style: textStyle.bodyLarge?.copyWith(
                  fontSize: 17,
                  color: color.outline.withValues(alpha: 0.7),
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Berat',
                  style: textStyle.titleLarge?.copyWith(
                    height: 1.1,
                    color: color.onSurfaceVariant,
                  ),
                ),
              ),
              trailing: CircularPercentIndicator(
                radius: 24.0,
                lineWidth: 6.0,
                percent: 0.75,
                animation: true,
                animationDuration: 700,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: color.surfaceContainerHighest,
                progressColor: _getRiskColor('sedang', color),
                center: Text(
                  '40',
                  style: textStyle.bodyMedium?.copyWith(
                    color: color.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

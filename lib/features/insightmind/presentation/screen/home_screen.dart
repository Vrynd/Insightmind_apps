import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/presentation/providers/history_provider.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/chat_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/history_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/screening_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/banner_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/empty_history.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/history_item.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/start_screening.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_action.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/login_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/alert_confirmation.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/title_page.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // State menyimpan apakah widget sedang di-scroll atau tidak
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;

  // Menginisialisasi state
  @override
  void initState() {
    super.initState();

    // Mendeteksi apakah user sedang melakukan scroll dengan listener
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && !_isScrolling) {
        setState(() => _isScrolling = true);
      } else if (_scrollController.offset <= 0 && _isScrolling) {
        setState(() => _isScrolling = false);
      }
    });
  }

  // Membebaskan controller agar tidak terjadi memory leak
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    // Mengambil data riwayat skrining dari provider
    final historyAsync = ref.watch(historyListProvider);

    return ScaffoldApp(
      backgroundColor: color.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: color.surface,
        actions: [
          IconButton(
            onPressed: () async {
              final confirm = await showConfirmationSheet(
                context: context,
                color: color,
                textStyle: textStyle,
                title: 'Konfirmasi Keluar',
                description: 'Apakah Anda yakin ingin keluar dari akun?',
                confirmTitle: 'Keluar',
                cancelTitle: 'Batal',
                icon: Icons.logout,
                iconColor: Colors.red,
              );
              if (confirm == true) {
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                }
              }
            },
            icon: Icon(Icons.logout, color: color.error),
          ),
          const SizedBox(width: 8),
        ],
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
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.blue.withOpacity(0.15),
              blurRadius: 30,
              spreadRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const ChatScreen()));
          },
          backgroundColor: Colors.blue[100],
          elevation: 0,
          child: Icon(Icons.chat_bubble, color: Colors.blue[800], size: 28),
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
            left: 18,
            right: 18,
            bottom: 30,
          ),
          children: [
            // Judul Halaman yang sedang aktif
            TitlePage(
              textStyle: textStyle,
              color: color,
              title: 'Selamat Datang',
            ),
            const SizedBox(height: 14),

            // Widget untuk menampilkan banner berupa gambar
            BannerApp(imagePath: 'assets/image/banner_mental_health.png'),
            const SizedBox(height: 14),

            // Widget untuk mulai melakukan skrining
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

            // Widget untuk menampilkan riwayat skrining
            TitleAction(
              textStyle: textStyle,
              color: color,
              mainTitle: 'Riwayat Skrining',
              // Memberikan informasi terkhir kali melakukan skrining
              subTitle: historyAsync.when(
                data: (records) {
                  if (records.isEmpty) {
                    return 'Belum ada riwayat'.toUpperCase();
                  }

                  // Mengurutkan data riwayat berdasarkan timestamp terbaru
                  final sortedRecords = [...records]
                    ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

                  final last = sortedRecords.first;

                  return 'Terakhir, '
                          '${last.timestamp.day} '
                          '${DateFormat('MMMM').format(last.timestamp)} '
                          '${last.timestamp.year}'
                      .toUpperCase();
                },
                loading: () => 'Memuat...',
                error: (_, __) => 'Gagal memuat',
              ),

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
            historyAsync.when(
              data: (items) {
                // Jika riwayat masih kosong, akan menampilkan widget empty history
                if (items.isEmpty) {
                  return EmptyHistory(
                    color: color,
                    textStyle: textStyle,
                    imagePath: 'assets/image/empty_box.png',
                    mainTitle: 'Belum Ada Riwayat',
                    subTitle:
                        'Mulai skrining pertama anda untuk melihat\nriwayat hasil di sini',
                  );
                }

                final sortedItems = [...items]
                  ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

                // Ambil 4 data TERBARU
                final latestRecords = sortedItems.take(4).toList();

                return Column(
                  children: latestRecords.asMap().entries.map((entry) {
                    final index = entry.key;
                    final r = entry.value;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: HistoryItem(
                        riskLevel: r.riskLevel,
                        color: color,
                        textStyle: textStyle,
                        mainTitle: 'Tingkat Risiko',
                        subTitle: r.riskLevel,
                        percent: r.score / 27,
                        score: r.score,
                        timestamp: r.timestamp,
                        showDeleteIcon: false,
                        isLatest: index == 0,
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Gagal memuat riwayat: $e')),
            ),
          ],
        ),
      ),
    );
  }
}

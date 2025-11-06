import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/data/local/history_repository.dart';
import 'package:insightmind_app/features/insightmind/data/local/screening_record.dart';

// Provider untuk mengakses repository riwayat
final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository();
});

// Provider Future untuk me-load semua riwayat
final historyListProvider = FutureProvider<List<ScreeningRecord>>((ref) async {
  final repo = ref.watch(historyRepositoryProvider);
  return repo.getAll();
});

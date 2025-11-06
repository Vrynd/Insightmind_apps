import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'screening_record.dart';

class HistoryRepository {
  static const String boxName = 'screening_record';

  // Buka box jika belum terbuka (lazy-open)
  Future<Box<ScreeningRecord>> _openBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<ScreeningRecord>(boxName);
    }
    return Hive.openBox<ScreeningRecord>(boxName);
  }

  // Tambah satu record riwayat (dipanggil saat hasil muncul)
  Future<void> addRecord({
    required int score,
    required String riskLevel,
    String? note,
  }) async {
    final box = await _openBox();
    final id = const Uuid().v4(); // ID unik
    final record = ScreeningRecord(
      id: id,
      timestamp: DateTime.now(),
      score: score,
      riskLevel: riskLevel,
      note: note,
    );
    await box.put(
      id,
      record,
    ); // simpan dengan key = id (mudah dihapus per item)
  }

  // Ambil semua riwayat (urutkan terbaru di atas)
  Future<List<ScreeningRecord>> getAll() async {
    final box = await _openBox();
    return box.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  // Hapus 1 item berdasarkan id
  Future<void> deleteById(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  // Kosongkan seluruh riwayat
  Future<void> clearAll() async {
    final box = await _openBox();
    await box.clear();
  }
}

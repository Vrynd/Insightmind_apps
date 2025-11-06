import 'package:hive/hive.dart';

part 'screening_record.g.dart'; // WEEK6: file adapter hasil generate build_runner

@HiveType(typeId: 1) // WEEK6: beri typeId unik untuk model ini
class ScreeningRecord extends HiveObject {
  @HiveField(0) // WEEK6: field ini akan diserialisasi sebagai kolom
  String id;

  @HiveField(1) // WEEK6
  DateTime timestamp;

  @HiveField(2) // WEEK6
  int score;

  @HiveField(3) // WEEK6
  String riskLevel;

  @HiveField(4) // WEEK6: opsional untuk catatan pengguna
  String? note;

  ScreeningRecord({
    required this.id,
    required this.timestamp,
    required this.score,
    required this.riskLevel,
    this.note,
  });
}

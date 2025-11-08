import 'package:hive/hive.dart';
part 'screening_record.g.dart'; // File adapter hasil generate build_runner

@HiveType(typeId: 1) // Beri typeId unik untuk model ini
class ScreeningRecord extends HiveObject {
  @HiveField(0) // Field ini akan diserialisasi sebagai kolom
  String id;

  @HiveField(1)
  DateTime timestamp;

  @HiveField(2)
  int score;

  @HiveField(3)
  String riskLevel;

  @HiveField(4)
  String? note;

  ScreeningRecord({
    required this.id,
    required this.timestamp,
    required this.score,
    required this.riskLevel,
    this.note,
  });
}

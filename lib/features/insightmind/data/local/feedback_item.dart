import 'package:hive/hive.dart';

part 'feedback_item.g.dart';

@HiveType(typeId: 3)
class FeedbackItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final String featureSuggestion;

  @HiveField(3)
  final String bugReport;

  @HiveField(4)
  final int satisfactionLevel;

  FeedbackItem({
    required this.id,
    required this.timestamp,
    required this.featureSuggestion,
    required this.bugReport,
    required this.satisfactionLevel,
  });
}

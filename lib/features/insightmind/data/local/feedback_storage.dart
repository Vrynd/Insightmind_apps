import 'package:hive/hive.dart';
import 'package:insightmind_app/features/insightmind/data/local/feedback_item.dart';

class FeedbackStorage {
  static const _boxName = 'feedbacks';

  static Box<FeedbackItem> get _box => Hive.box<FeedbackItem>(_boxName);

  static Future<void> saveFeedback({
    required String id,
    required DateTime timestamp,
    required String featureSuggestion,
    required String bugReport,
    required int satisfactionLevel,
  }) async {
    final item = FeedbackItem(
      id: id,
      timestamp: timestamp,
      featureSuggestion: featureSuggestion,
      bugReport: bugReport,
      satisfactionLevel: satisfactionLevel,
    );
    await _box.add(item);
  }

  static List<FeedbackItem> allFeedbacks() {
    return _box.values.toList();
  }

  static Future<void> clearAll() async {
    await _box.clear();
  }
}

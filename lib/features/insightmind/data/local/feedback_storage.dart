import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FeedbackStorage {
  static const _fileName = 'feedbacks.json';

  static Future<File> _localFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  static Future<List<Map<String, dynamic>>> _readAll() async {
    try {
      final file = await _localFile();
      if (!await file.exists()) return [];
      final content = await file.readAsString();
      if (content.isEmpty) return [];
      final list = json.decode(content) as List<dynamic>;
      return list.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> saveFeedback(Map<String, dynamic> feedback) async {
    final list = await _readAll();
    list.add(feedback);
    final file = await _localFile();
    await file.writeAsString(json.encode(list));
  }

  static Future<List<Map<String, dynamic>>> allFeedbacks() async {
    return await _readAll();
  }
}

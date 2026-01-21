import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:insightmind_app/features/insightmind/data/local/feedback_item.dart';
import 'package:insightmind_app/features/insightmind/data/local/screening_record.dart';
import 'package:insightmind_app/features/insightmind/data/local/user.dart';
import 'package:insightmind_app/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ScreeningRecordAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(FeedbackItemAdapter());

  await Hive.openBox<ScreeningRecord>('screening_records');
  await Hive.openBox<User>('users');
  await Hive.openBox<FeedbackItem>('feedbacks');

  runApp(const ProviderScope(child: InsightMindApp()));
}

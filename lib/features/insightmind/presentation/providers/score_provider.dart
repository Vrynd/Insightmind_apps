import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:insightmind_app/features/insightmind/data/repositories/score_repository.dart';
import 'package:insightmind_app/features/insightmind/domain/usecases/calculate_risk_level.dart';

final answersProvider = StateProvider<List<int>>((ref) => []);

final scoreRepositoryProvider = Provider<ScoreRepository>((ref) {
  return ScoreRepository();
});


final calculateRiskProvider = Provider<CalculateRiskLevel>((ref) {
  return CalculateRiskLevel();
});

final scoreProvider = Provider<int>((ref) {
  final repo = ref.watch(scoreRepositoryProvider);
  final answers = ref.watch(answersProvider);
  return repo.calculateScore(answers);
});

final resultProvider = Provider((ref) {
  final score = ref.watch(scoreProvider);
  final usecase = ref.watch(calculateRiskProvider);
  return usecase.execute(score);
});
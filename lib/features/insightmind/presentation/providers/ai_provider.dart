import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightmind_app/features/insightmind/data/models/feature_vector.dart';
import 'package:insightmind_app/features/insightmind/domain/usecases/predict_risk_ai.dart';

final aiPredictorProvider = Provider<PredictRiskAI>((ref) {
  return PredictRiskAI();
});

final aiResultProvider =
    FutureProvider.family<Map<String, dynamic>, FeatureVector>((ref, fv) async {
      final model = ref.watch(aiPredictorProvider);
      return model.predict(fv);
    });

import 'package:insightmind_app/features/insightmind/data/models/feature_vector.dart';
import 'package:insightmind_app/features/insightmind/domain/usecases/calculate_risk_level.dart';

class PredictRiskAI {
  Map<String, dynamic> predict(FeatureVector f) {
    // Normalisasi (0–1)
    final double normPhq = f.screeningScore / 27.0;
    final double normActivity = f.activityVar.clamp(0.0, 1.0);
    final double normPpg = f.ppgVar.clamp(0.0, 1.0);

    // Weighted fusion
    final double fusedScore =
        normPhq * 0.6 +
        normActivity * 0.2 +
        normPpg * 0.2;

    // Konversi ke skala PHQ-9
    final int phqEquivalentScore = (fusedScore * 27).round();

    // Gunakan 1 source untuk penilaian risiko
    final mentalResult = CalculateRiskLevel().execute(phqEquivalentScore);

    // Confidence (opsional)
    final double confidence =
        (0.5 + (fusedScore - normPhq).abs()).clamp(0.3, 0.95);

    return {
      'phqEquivalentScore': phqEquivalentScore,
      'riskLevel': mentalResult.riskLevel,
      'confidence': confidence,
    };
  }
}

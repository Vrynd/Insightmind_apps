import 'package:insightmind_app/features/insightmind/data/models/feature_vector.dart';

class PredictRiskAI {
  Map<String, dynamic> predict(FeatureVector f) {
    // Weighted score
    double weightedScore = f.screeningScore * 0.6 +
        (f.activityVar * 10) * 0.2 +
        (f.ppgVar * 1000) * 0.2;

    String level;
    if (weightedScore > 25) {
      level = 'Tinggi';
    } else if (weightedScore > 12) {
      level = 'Sedang';
    } else {
      level = 'Rendah';
    }

    // Confidence score sederhana
    double confidence = (weightedScore / 30).clamp(0.3, 0.95);

    return {
      'weightedScore': weightedScore,
      'riskLevel': level,
      'confidence': confidence,
    };
  }
}
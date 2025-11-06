import 'package:insightmind_app/features/insightmind/domain/entities/mental_result.dart';

class CalculateRiskLevel {
  MentalResult execute(int score) {
    String risk;

    if (score <= 4) {
      risk = "Minimal";
    } else if (score <= 9) {
      risk = "Ringan";
    } else if (score <= 14) {
      risk = "Sedang";
    } else if (score <= 19) {
      risk = "Cukup Berat";
    } else {
      risk = "Berat";
    }

    return MentalResult(score: score, riskLevel: risk);
  }
}

class FeatureVector {
  final double screeningScore;
  final double activityMean;
  final double activityVar;
  final double ppgMean;
  final double ppgVar;

  FeatureVector({
    required this.screeningScore,
    required this.activityMean,
    required this.activityVar,
    required this.ppgMean,
    required this.ppgVar,
  });
}
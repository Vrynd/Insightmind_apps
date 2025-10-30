class ScoreRepository {
  int calculateScore(List<int> asnwer) {
    if (asnwer.isEmpty) return 0;
    return asnwer.reduce((a, b) => a + b);
  }
}

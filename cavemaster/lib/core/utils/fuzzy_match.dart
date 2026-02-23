/// Levenshtein distance-based fuzzy matching for wine name/producer lookup.
abstract final class FuzzyMatch {
  /// Returns a similarity score between 0.0 (no match) and 1.0 (exact).
  static double score(String a, String b) {
    final s1 = a.toLowerCase().trim();
    final s2 = b.toLowerCase().trim();
    if (s1 == s2) return 1.0;
    if (s1.isEmpty || s2.isEmpty) return 0.0;

    final distance = _levenshtein(s1, s2);
    final maxLen = s1.length > s2.length ? s1.length : s2.length;
    return 1.0 - (distance / maxLen);
  }

  /// Returns true if similarity score >= [threshold] (default 0.75).
  static bool isMatch(String a, String b, {double threshold = 0.75}) {
    return score(a, b) >= threshold;
  }

  /// Finds the best match from [candidates] for [query].
  /// Returns null if no candidate meets [threshold].
  static ({String match, double score})? bestMatch(
    String query,
    Iterable<String> candidates, {
    double threshold = 0.6,
  }) {
    String? bestCandidate;
    double bestScore = threshold;

    for (final candidate in candidates) {
      final s = score(query, candidate);
      if (s > bestScore) {
        bestScore = s;
        bestCandidate = candidate;
      }
    }

    if (bestCandidate == null) return null;
    return (match: bestCandidate, score: bestScore);
  }

  static int _levenshtein(String s1, String s2) {
    final m = s1.length;
    final n = s2.length;
    final dp = List.generate(m + 1, (_) => List<int>.filled(n + 1, 0));

    for (var i = 0; i <= m; i++) dp[i][0] = i;
    for (var j = 0; j <= n; j++) dp[0][j] = j;

    for (var i = 1; i <= m; i++) {
      for (var j = 1; j <= n; j++) {
        if (s1[i - 1] == s2[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] = 1 +
              [dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]]
                  .reduce((a, b) => a < b ? a : b);
        }
      }
    }
    return dp[m][n];
  }
}

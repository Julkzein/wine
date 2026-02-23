import '../models/wine.dart';
import '../../core/constants/wine_enums.dart';

class ScoredWine {
  final Wine wine;
  final double score;
  final DrinkingStatus status;

  const ScoredWine({required this.wine, required this.score, required this.status});
}

class RecommendationService {
  /// Returns all wines scored and sorted by urgency/desirability.
  /// [mealType] is an optional food pairing hint (e.g., 'Red meat').
  List<ScoredWine> score(List<Wine> collection, {String? mealType}) {
    final currentYear = DateTime.now().year;

    final scored = collection
        .where((w) => w.quantity > 0)
        .map((wine) {
          final status = getDrinkingStatus(wine);
          double s = 0;

          // Urgency: wines closer to end of window score higher.
          if (wine.drinkUntil != null) {
            final yearsLeft = wine.drinkUntil! - currentYear;
            if (yearsLeft <= 0) s += 100; // Past peak
            else if (yearsLeft <= 1) s += 80;
            else if (yearsLeft <= 2) s += 60;
            else if (yearsLeft <= 3) s += 40;
            else if (yearsLeft <= 5) s += 20;
          }

          // Peak bonus.
          if (status == DrinkingStatus.peak) s += 40;

          // User rating boost (max +25).
          if (wine.userRating != null) s += wine.userRating! * 5;

          // Food pairing match.
          if (mealType != null && wine.foodPairings.contains(mealType)) s += 30;

          // Slight penalty for wines with no drinking window data.
          if (!wine.hasDrinkingWindow) s -= 10;

          return ScoredWine(wine: wine, score: s, status: status);
        })
        .toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    return scored;
  }

  /// Filters to wines in peak or drinkNow status.
  List<Wine> getDrinkNow(List<Wine> collection) {
    final now = DateTime.now().year;
    return collection
        .where((w) =>
            w.quantity > 0 &&
            w.drinkFrom != null &&
            now >= w.drinkFrom! &&
            (w.drinkUntil == null || now <= w.drinkUntil!))
        .toList()
      ..sort((a, b) {
        final aUntil = a.drinkUntil ?? 9999;
        final bUntil = b.drinkUntil ?? 9999;
        return aUntil.compareTo(bUntil);
      });
  }

  /// Wines entering their window within the next 24 months.
  List<Wine> getDrinkSoon(List<Wine> collection) {
    final now = DateTime.now().year;
    return collection
        .where((w) =>
            w.quantity > 0 &&
            w.drinkUntil != null &&
            now <= w.drinkUntil! &&
            w.drinkUntil! - now <= 2)
        .toList()
      ..sort((a, b) => (a.drinkUntil ?? 9999).compareTo(b.drinkUntil ?? 9999));
  }

  /// Wines still aging (drinkFrom is in the future).
  List<Wine> getKeepAging(List<Wine> collection) {
    final now = DateTime.now().year;
    return collection
        .where((w) =>
            w.quantity > 0 &&
            w.drinkFrom != null &&
            now < w.drinkFrom!)
        .toList()
      ..sort((a, b) => (a.drinkFrom ?? 9999).compareTo(b.drinkFrom ?? 9999));
  }

  /// Wines past their drinking window.
  List<Wine> getPastPeak(List<Wine> collection) {
    final now = DateTime.now().year;
    return collection
        .where((w) => w.quantity > 0 && w.drinkUntil != null && now > w.drinkUntil!)
        .toList()
      ..sort((a, b) => (b.drinkUntil ?? 0).compareTo(a.drinkUntil ?? 0));
  }

  DrinkingStatus getDrinkingStatus(Wine wine) {
    final year = DateTime.now().year;
    if (!wine.hasDrinkingWindow) return DrinkingStatus.unknown;
    if (wine.drinkUntil != null && year > wine.drinkUntil!) return DrinkingStatus.pastPeak;
    if (wine.peakFrom != null &&
        wine.peakUntil != null &&
        year >= wine.peakFrom! &&
        year <= wine.peakUntil!) return DrinkingStatus.peak;
    if (wine.drinkFrom != null && year >= wine.drinkFrom!) {
      final yearsLeft = wine.drinkUntil != null ? wine.drinkUntil! - year : 999;
      return yearsLeft <= 2 ? DrinkingStatus.drinkSoon : DrinkingStatus.drinkNow;
    }
    return DrinkingStatus.keepAging;
  }
}

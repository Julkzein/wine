import 'package:intl/intl.dart';

abstract final class Formatters {
  static final _currencyFmt = NumberFormat.currency(symbol: '€', decimalDigits: 2);
  static final _compactCurrencyFmt = NumberFormat.currency(symbol: '€', decimalDigits: 0);
  static final _dateFmt = DateFormat('d MMM yyyy');
  static final _shortDateFmt = DateFormat('MMM yyyy');

  static String price(double? price) {
    if (price == null) return '—';
    return price >= 1000 ? _compactCurrencyFmt.format(price) : _currencyFmt.format(price);
  }

  static String date(DateTime? date) {
    if (date == null) return '—';
    return _dateFmt.format(date);
  }

  static String monthYear(DateTime? date) {
    if (date == null) return '—';
    return _shortDateFmt.format(date);
  }

  static String vintage(int? vintage) {
    if (vintage == null) return 'NV';
    return vintage.toString();
  }

  static String alcohol(double? alcohol) {
    if (alcohol == null) return '—';
    return '${alcohol.toStringAsFixed(1)}% vol';
  }

  static String quantity(int quantity) {
    return quantity == 1 ? '1 bottle' : '$quantity bottles';
  }

  static String drinkingWindow(int? from, int? until) {
    if (from == null && until == null) return 'No window set';
    if (from == null) return 'Until $until';
    if (until == null) return 'From $from';
    return '$from – $until';
  }

  static String rating(double? rating) {
    if (rating == null) return '—';
    return rating.toStringAsFixed(1);
  }

  static String totalValue(List<({double? price, int quantity})> wines) {
    final total = wines.fold<double>(
      0,
      (sum, w) => sum + (w.price ?? 0) * w.quantity,
    );
    return _currencyFmt.format(total);
  }
}

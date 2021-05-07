import '../enumerations/currency.dart';
import '../models/exchange_rate.dart';
export '../extensions/list_money_transaction_x.dart';

/// This extension provides additional functionality for `List<ExchangeRate>`.
///
extension ListExchangeRateX on List<ExchangeRate> {
  /// Returns the exchange rate which matches with [from] and [to] currencies.
  /// If this does not exist in this list, it returns `null`.
  ///
  ExchangeRate? getExchangeRate({
    required Currency from,
    required Currency to,
  }) {
    try {
      return firstWhere((e) => e.from == from && e.to == to);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return null;
    }
  }

  /// Returns the exchange rate which matches with [from] and [to] currencies and refers to the same day.
  /// If this does not exist in this list, it returns `null`.
  ///
  ExchangeRate? getExchangeRateSameDay({
    required DateTime dateTime,
    required Currency from,
    required Currency to,
  }) {
    try {
      return firstWhere((e) =>
          e.from == from &&
          e.to == to &&
          e.dateTime.year == dateTime.year &&
          e.dateTime.month == dateTime.month &&
          e.dateTime.day == dateTime.day);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return null;
    }
  }
}

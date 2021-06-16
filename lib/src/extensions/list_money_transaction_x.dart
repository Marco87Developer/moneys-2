import '../enumerations/currency.dart';
import '../enumerations/expense_or_income.dart';
import '../enumerations/money_transaction_method.dart';
import '../models/exchange_rate.dart';
import '../models/money.dart';
import '../models/money_transaction.dart';
import 'list_exchange_rate_x.dart';

/// This extension provides additional functionality for
/// `List<MoneyTransaction>`.
///
extension ListMoneyTransactionX on List<MoneyTransaction> {
  /// Adds the [moneyTransaction] to this list if the latter does not already
  /// contain it. Also, sorts it.
  ///
  void addMoneyTransaction(MoneyTransaction moneyTransaction) {
    if (!contains(moneyTransaction)) {
      add(moneyTransaction);
      sort();
    }
  }

  /// Returns the comparison to [other] list of `MoneyTransaction`.
  ///
  int compareTo(List<MoneyTransaction> other) {
    sort();
    other.sort();

    return last.compareTo(other.last);
  }

  /// Fills this list starting from the `List<dynamic>` [list].
  ///
  /// This can be useful for retrieving a `List<MoneyTransaction>` from a
  /// database.
  ///
  List<MoneyTransaction> fromList(List<dynamic> list) {
    for (final dynamic map in list)
      add(MoneyTransaction.fromMap(map as Map<String, dynamic>));
    sort();
    return this;
  }

  /// Creates a `List<Map<String, dynamic>>` representation of this list.
  ///
  /// This can be useful for saving the list in a database.
  ///
  List<Map<String, dynamic>> toListOfMaps() {
    sort();

    return isEmpty
        ? []
        : [
            for (final MoneyTransaction transaction in this)
              transaction.toMap(),
          ];
  }

  /// Normalizes all values to the same [currency]. For this, [exchangeRates]
  /// list must contain all the exchange rates necessary for conversions. If
  /// even one of these is missing, throws a `FormatException`.
  ///
  /// The result list is sorted.
  ///
  List<MoneyTransaction> normalize({
    required Currency currency,
    List<ExchangeRate>? exchangeRates,
  }) {
    final List<MoneyTransaction> normalized = [];

    if (exchangeRates != null && exchangeRates.isNotEmpty) {
      for (final MoneyTransaction transaction in this) {
        if (transaction.value.currency == currency) {
          normalized.add(transaction);
        } else {
          final ExchangeRate? rate = exchangeRates.getExchangeRate(
            from: transaction.value.currency,
            to: currency,
          );

          if (rate == null) {
            throw const FormatException(
                'exchangeRates list does not contain the exchange rate to carry'
                ' out the conversion.');
          }

          normalized.add(
            transaction.copyWith(
              value: Money(
                amount: transaction.value.convert(rate: rate).amount,
                currency: currency,
              ),
            ),
          );
        }
      }
    } else {
      for (final MoneyTransaction transaction in this) {
        if (transaction.value.currency == currency) {
          normalized.add(transaction);
        } else {
          throw const FormatException(
              'exchangeRates list does not contain the exchange rate to carry'
              ' out the conversion.');
        }
      }
    }

    normalized.sort();

    return normalized;
  }

  /// Calculates and returns the sum of all transactions of this list. Also,
  /// allows to perform the sum of only expenses or only income. It is also
  /// possible to limit the sum to a time interval.
  ///
  /// The sum is done by normalizing all values to the same [currency]. For
  /// this, [exchangeRates] list must contain all the exchange rates necessary
  /// for conversions. If even one of these is missing, throws a
  /// `FormatException`.
  ///
  Money total({
    required Currency currency,
    List<ExchangeRate>? exchangeRates,
    DateTime? from,
    ExpenseOrIncome? expenseOrIncome,
    DateTime? until,
  }) {
    if (isEmpty) return Money(amount: 0, currency: currency);

    final List<MoneyTransaction> listEOI = expenseOrIncome == null
        ? this
        : where((e) => e.expenseOrIncome == expenseOrIncome).toList();
    final List<MoneyTransaction> listFrom = from == null
        ? listEOI
        : listEOI
            .where((e) =>
                e.dateTime.isAtSameMomentAs(from) || e.dateTime.isAfter(from))
            .toList();
    final List<MoneyTransaction> listUntil = until == null
        ? listFrom
        : listFrom
            .where((e) =>
                e.dateTime.isAtSameMomentAs(until) ||
                e.dateTime.isBefore(until))
            .toList()
      ..sort();

    final List<MoneyTransaction> normalizedTransactions = listUntil.normalize(
      currency: currency,
      exchangeRates: exchangeRates,
    );

    final List<Money> expenseValues = normalizedTransactions
        .where((t) => t.expenseOrIncome == ExpenseOrIncome.expense)
        .map<Money>((t) => t.value)
        .toList()
          ..sort();
    final List<Money> incomeValues = normalizedTransactions
        .where((t) => t.expenseOrIncome == ExpenseOrIncome.income)
        .map<Money>((t) => t.value)
        .toList()
          ..sort();

    final Money expenseTotal = expenseValues.fold<Money>(
      Money(amount: 0, currency: currency),
      (previousValue, money) => previousValue + money,
    );
    final Money incomeTotal = incomeValues.fold<Money>(
      Money(amount: 0, currency: currency),
      (previousValue, money) => previousValue + money,
    );

    if (expenseOrIncome == ExpenseOrIncome.expense) {
      return expenseTotal;
    } else {
      return incomeTotal - expenseTotal;
    }
  }

  /// Returns a filtered list of all the transactions in whose method was
  /// [method]. The result is already sorted.
  ///
  /// If a normalized list is expected as a result, it is possible to set
  /// [normalized] equal to `true`. In this case, the [currency] parameter must
  /// also be specified, otherwise a `FormatException` will be thrown. The
  /// [exchangeRates] parameter is also expected to be specified.
  ///
  List<MoneyTransaction> whoseMethodWas({
    Currency? currency,
    List<ExchangeRate>? exchangeRates,
    required MoneyTransactionMethod method,
    bool normalized = false,
  }) {
    if (normalized && currency == null) {
      throw const FormatException(
          'whoseMethodWas: You cannot normalize a list without specifying the'
          ' currency against which you want to normalize it.');
    }

    final result =
        where((moneyTransaction) => moneyTransaction.method == method).toList()
          ..sort();

    if (normalized && currency != null) {
      return result.normalize(
        currency: currency,
        exchangeRates: exchangeRates,
      );
    }

    return result;
  }

  /// Return a filtered list of all the transactions with a value = [value].
  ///
  /// Before filtering the transactions, this list is normalized to the
  /// [currency] or, when this is `null`, to the currency of the [value]. Also,
  /// the result is already sorted.
  ///
  List<MoneyTransaction> withValueEqualTo({
    Currency? currency,
    List<ExchangeRate>? exchangeRates,
    bool normalized = false,
    required Money value,
  }) =>
      _valueFilter(
        comparison: (actual, target) => actual == target,
        currency: currency,
        exchangeRates: exchangeRates,
        normalized: normalized,
        value: value,
      );

  /// Return a filtered list of all the transactions with a value > [value].
  ///
  /// Before filtering the transactions, this list is normalized to the currency
  /// of the [value]. Also, the result is already sorted.
  ///
  List<MoneyTransaction> withValueGreaterThan({
    Currency? currency,
    List<ExchangeRate>? exchangeRates,
    bool normalized = false,
    required Money value,
  }) =>
      _valueFilter(
        comparison: (actual, target) => actual > target,
        currency: currency,
        exchangeRates: exchangeRates,
        normalized: normalized,
        value: value,
      );

  /// Return a filtered list of all the transactions with a value >= [value].
  ///
  /// Before filtering the transactions, this list is normalized to the currency
  /// of the [value]. Also, the result is already sorted.
  ///
  List<MoneyTransaction> withValueGreaterThanOrEqualTo({
    Currency? currency,
    List<ExchangeRate>? exchangeRates,
    bool normalized = false,
    required Money value,
  }) =>
      _valueFilter(
        comparison: (actual, target) => actual >= target,
        currency: currency,
        exchangeRates: exchangeRates,
        normalized: normalized,
        value: value,
      );

  /// Return a filtered list of all the transactions with a value < [value].
  ///
  /// Before filtering the transactions, this list is normalized to the currency
  /// of the [value]. Also, the result is already sorted.
  ///
  List<MoneyTransaction> withValueLessThan({
    Currency? currency,
    List<ExchangeRate>? exchangeRates,
    bool normalized = false,
    required Money value,
  }) =>
      _valueFilter(
        comparison: (actual, target) => actual < target,
        currency: currency,
        exchangeRates: exchangeRates,
        normalized: normalized,
        value: value,
      );

  /// Return a filtered list of all the transactions with a value <= [value].
  ///
  /// Before filtering the transactions, this list is normalized to the currency
  /// of the [value]. Also, the result is already sorted.
  ///
  List<MoneyTransaction> withValueLessThanOrEqualTo({
    Currency? currency,
    List<ExchangeRate>? exchangeRates,
    bool normalized = false,
    required Money value,
  }) =>
      _valueFilter(
        comparison: (actual, target) => actual <= target,
        currency: currency,
        exchangeRates: exchangeRates,
        normalized: normalized,
        value: value,
      );

  /// Return a filtered list of all the transactions as expressed by
  /// [comparison] function.
  ///
  /// Before filtering the transactions, this list is normalized to the
  /// [currency] or, when this is `null`, to the currency of the [value]. Also,
  /// the result is already sorted.
  ///
  List<MoneyTransaction> _valueFilter({
    required bool Function(Money actual, Money target) comparison,
    Currency? currency,
    List<ExchangeRate>? exchangeRates,
    bool normalized = false,
    required Money value,
  }) {
    final Currency actualCurrency = currency ?? value.currency;

    Money actualValue;

    if (value.currency != actualCurrency) {
      final ExchangeRate? rate = exchangeRates?.getExchangeRate(
        from: value.currency,
        to: actualCurrency,
      );

      if (rate == null) {
        throw const FormatException(
            'withValueEqualTo: exchangeRates does not contain the needed rate.');
      }

      actualValue = value.convert(rate: rate);
    } else {
      actualValue = value;
    }

    final List<MoneyTransaction> filtered = where((t) {
      if (t.value.currency == actualCurrency) {
        return comparison(t.value, actualValue);
      }

      if (exchangeRates == null || exchangeRates.isEmpty)
        throw const FormatException(
            'withValueEqualTo: It is necessary to convert the value of this'
            ' transaction, but the exchangeRates parameter is null or its list'
            ' is empty.');

      final ExchangeRate? rate = exchangeRates.getExchangeRate(
        from: t.value.currency,
        to: actualCurrency,
      );

      if (rate == null) {
        throw const FormatException(
            'withValueEqualTo: It is necessary to convert the value of this'
            ' transaction, but the exchangeRates does not contain the exchange'
            ' rate to carry out the conversion.');
      }

      return comparison(t.value.convert(rate: rate), actualValue);
    }).toList()
      ..sort();

    return normalized
        ? filtered.normalize(
            currency: actualCurrency,
            exchangeRates: exchangeRates,
          )
        : filtered;
  }
}

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

    return [
      for (final MoneyTransaction transaction in this) transaction.toMap(),
    ];
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

    final List<Money> normalized = [];

    print('ℹ Exchange rate length: ${exchangeRates?.length}');

    if (exchangeRates != null && exchangeRates.isNotEmpty) {
      print('ℹ Exchange is not null nor empty.');

      for (final MoneyTransaction transaction in listUntil) {
        if (transaction.value.currency == currency) {
          normalized.add(
            Money(
              amount: transaction.expenseOrIncome == ExpenseOrIncome.income
                  ? transaction.value.amount
                  : -transaction.value.amount,
              currency: currency,
            ),
          );
        } else {
          final ExchangeRate? rate = exchangeRates.getExchangeRate(
            from: transaction.value.currency,
            to: currency,
          );

          String fromString = transaction.value.currency.string();
          String toString = currency.string();

          if (rate == null) {
            /// TODO: Remove this print() statement
            print('ℹ FormatException $fromString to $toString');
            throw const FormatException(
                'exchangeRates list does not contain the exchange rate to carry'
                ' out the conversion.');
          }

          normalized.add(
            Money(
              amount: transaction.expenseOrIncome == ExpenseOrIncome.income
                  ? transaction.value.convert(rate: rate).amount
                  : -transaction.value.convert(rate: rate).amount,
              currency: currency,
            ),
          );
        }
      }
    } else {
      for (final MoneyTransaction transaction in listUntil) {
        if (transaction.value.currency == currency) {
          normalized.add(
            Money(
              amount: transaction.expenseOrIncome == ExpenseOrIncome.income
                  ? transaction.value.amount
                  : -transaction.value.amount,
              currency: currency,
            ),
          );
        } else {
          throw const FormatException(
              'exchangeRates list does not contain the exchange rate to carry'
              ' out the conversion.');
        }
      }
    }

    Money result = normalized.fold<Money>(
      Money(amount: 0, currency: currency),
      (previousValue, money) => previousValue + money,
    );

    return Money(
      amount: result.amount >= 0 ? result.amount : -result.amount,
      currency: currency,
    );
  }

  /// Returns an unmodifiable list of all the transactions in whose method was
  /// [method].
  ///
  List<MoneyTransaction> whoseMethodWas(MoneyTransactionMethod method) {
    final List<MoneyTransaction> filtered =
        where((moneyTransaction) => moneyTransaction.method == method).toList()
          ..sort();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value =
  /// [value].
  ///
  List<MoneyTransaction> withValueEqualTo(Money value) {
    final List<MoneyTransaction> filtered =
        where((moneyTransaction) => moneyTransaction.value == value).toList()
          ..sort();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value >
  /// [value].
  ///
  List<MoneyTransaction> withValueGreaterThan(Money value) {
    final List<MoneyTransaction> filtered =
        where((moneyTransaction) => moneyTransaction.value > value).toList()
          ..sort();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value >=
  /// [value].
  ///
  List<MoneyTransaction> withValueGreaterThanOrEqualTo(Money value) {
    final List<MoneyTransaction> filtered =
        where((moneyTransaction) => moneyTransaction.value >= value).toList()
          ..sort();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value <
  /// [value].
  ///
  List<MoneyTransaction> withValueLessThan(Money value) {
    final List<MoneyTransaction> filtered =
        where((moneyTransaction) => moneyTransaction.value < value).toList()
          ..sort();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value <=
  /// [value].
  ///
  List<MoneyTransaction> withValueLessThanOrEqualTo(Money value) {
    final List<MoneyTransaction> filtered =
        where((moneyTransaction) => moneyTransaction.value <= value).toList()
          ..sort();

    return List.unmodifiable(filtered);
  }
}

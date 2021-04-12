import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:moneys/src/enumerations/currency.dart';
import 'package:moneys/src/enumerations/expense_or_income.dart';
import 'package:moneys/src/enumerations/money_transaction_method.dart';
import 'package:moneys/src/models/money.dart';
import 'package:moneys/src/models/money_transaction.dart';

/// This class models an history of money transactions. It has methods in order
/// to manage that history.
///
class MoneyTransactions implements Comparable {
  /// Default constructor.
  ///
  MoneyTransactions();

  /// Returns a instance of `MoneyTransactions` with the history contained in
  /// the [listOfMaps].
  ///
  MoneyTransactions.fromListOfMaps(List<Map<String, dynamic>> listOfMaps) {
    for (final Map<String, dynamic> map in listOfMaps) {
      _history.add(MoneyTransaction.fromMap(map));
    }
  }

  final SplayTreeSet<MoneyTransaction> _history = SplayTreeSet();

  /// Returns an unmodifiable `List` of the *entire* [history] of the
  /// transactions.
  ///
  List<MoneyTransaction> get history => List.unmodifiable(_history.toList());

  /// Adds the [moneyTransaction] to the history of the transactions.
  ///
  void add(MoneyTransaction moneyTransaction) => _history.add(moneyTransaction);

  double _historyReduced() {
    double sum = 0;

    for (final MoneyTransaction moneyTransaction in history) {
      sum += moneyTransaction.value.amount;
    }

    return sum;
  }

  /// Returns an unmodifiable list of all transactions made on the [dateTime].
  ///
  List<MoneyTransaction> madeAtDateTime(DateTime dateTime) {
    final List<MoneyTransaction> filtered = _history
        .where((moneyTransaction) =>
            moneyTransaction.dateTime.isAtSameMomentAs(dateTime))
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Returns an unmodifiable list of all transactions made on the [dateTime] or
  /// *after*.
  ///
  List<MoneyTransaction> madeAtDateTimeOrAfter(DateTime dateTime) {
    final List<MoneyTransaction> filtered = _history
        .where((moneyTransaction) =>
            moneyTransaction.dateTime.isAtSameMomentAs(dateTime) ||
            moneyTransaction.dateTime.isAfter(dateTime))
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Returns an unmodifiable list of all transactions made on the [dateTime] of
  /// *before*.
  ///
  List<MoneyTransaction> madeAtDateTimeOrBefore(DateTime dateTime) {
    final List<MoneyTransaction> filtered = _history
        .where((moneyTransaction) =>
            moneyTransaction.dateTime.isAtSameMomentAs(dateTime) ||
            moneyTransaction.dateTime.isBefore(dateTime))
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Removes the [moneyTransaction] from the history of the transactions.
  ///
  void remove(MoneyTransaction moneyTransaction) =>
      _history.remove(moneyTransaction);

  /// Generates a `List<Map<String, dynamic>>` where the elements are
  /// representations of all the transactions saved in this instance.
  ///
  List<Map<String, dynamic>> toListOfMaps() => [
        for (MoneyTransaction moneyTransaction in history)
          moneyTransaction.toMap(),
      ];

  /// Return the total of the transactions.
  ///
  /// It is possible to have the total of *all* the transactions, the incomes or
  /// the expenses (that is, taking into account the entire [history]). Also, it
  /// is possible to filter with respect to [from] and [until] dates, or only
  /// one of these two dates, or none.
  ///
  Money total({
    DateTime? from,
    required ExpenseOrIncome incomeOrExpense,
    DateTime? until,
  }) {
    final Currency currency = _history.first.value.currency;

    Money result = Money(amount: 0, currency: currency);

    if (from == null && until == null) {
      for (final MoneyTransaction moneyTransaction in _history) {
        if (moneyTransaction.expenseOrIncome == incomeOrExpense) {
          result += moneyTransaction.value;
        }
      }

      return result;
    }

    /// Only [until] is specified.
    if (from == null && until != null) {
      for (final MoneyTransaction moneyTransaction in _history) {
        if (moneyTransaction.expenseOrIncome == incomeOrExpense &&
            (moneyTransaction.dateTime.isBefore(until) ||
                moneyTransaction.dateTime.isAtSameMomentAs(until))) {
          result += moneyTransaction.value;
        }
      }

      return result;
    }

    /// Only [from] is specified.
    if (from != null && until == null) {
      for (final MoneyTransaction moneyTransaction in _history) {
        if (moneyTransaction.expenseOrIncome == incomeOrExpense &&
            (moneyTransaction.dateTime.isAfter(from) ||
                moneyTransaction.dateTime.isAtSameMomentAs(from))) {
          result += moneyTransaction.value;
        }
      }

      return result;
    }

    /// Both [from] and [until] are specified.
    if (from != null && until != null) {
      for (final MoneyTransaction moneyTransaction in _history) {
        if (moneyTransaction.expenseOrIncome == incomeOrExpense &&
            (moneyTransaction.dateTime.isAfter(from) ||
                moneyTransaction.dateTime.isAtSameMomentAs(from)) &&
            (moneyTransaction.dateTime.isBefore(until) ||
                moneyTransaction.dateTime.isAtSameMomentAs(until))) {
          result += moneyTransaction.value;
        }
      }

      return result;
    }

    return result;
  }

  /// Returns an unmodifiable list of all the transactions in whose method was
  /// [method].
  ///
  List<MoneyTransaction> whoseMethodWas(MoneyTransactionMethod method) {
    final List<MoneyTransaction> filtered = _history
        .where((moneyTransaction) => moneyTransaction.method == method)
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value >=
  /// [value].
  ///
  List<MoneyTransaction> withValueGreaterThanOrEqualTo(Money value) {
    final List<MoneyTransaction> filtered = _history
        .where((moneyTransaction) => moneyTransaction.value >= value)
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value >
  /// [value].
  ///
  List<MoneyTransaction> withValueGreaterThan(Money value) {
    final List<MoneyTransaction> filtered = _history
        .where((moneyTransaction) => moneyTransaction.value > value)
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value <
  /// [value].
  ///
  List<MoneyTransaction> withValueLessThan(Money value) {
    final List<MoneyTransaction> filtered = _history
        .where((moneyTransaction) => moneyTransaction.value < value)
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value <=
  /// [value].
  ///
  List<MoneyTransaction> withValueLessThanOrEqualTo(Money value) {
    final List<MoneyTransaction> filtered = _history
        .where((moneyTransaction) => moneyTransaction.value <= value)
        .toList();

    return List.unmodifiable(filtered);
  }

  /// The order of the comparisons is:
  ///
  /// 1. [history[0]]
  /// 2. [history[1]]
  /// 3. [history[…]]
  /// …
  /// 4. [history[history.length - 1]]
  ///
  @override
  int compareTo(covariant MoneyTransactions other) {
    for (int i = 0; i < history.length; i++) {
      final int comparison = history[i].compareTo(other.history[i]);
      if (comparison != 0) return comparison;
    }

    return 0;
  }

  @override
  int get hashCode => hashValues(_historyReduced(), _history.length);

  /// Returns if this instance is less than the [other].
  ///
  bool operator <(covariant MoneyTransactions other) => compareTo(other) < 0;

  /// Return if this instance is less than or equal to the [other].
  ///
  bool operator <=(covariant MoneyTransactions other) => compareTo(other) <= 0;

  @override
  bool operator ==(covariant MoneyTransactions other) => compareTo(other) == 0;

  /// Return if this instance is greater than or equal to the [other].
  ///
  bool operator >=(covariant MoneyTransactions other) => compareTo(other) >= 0;

  /// Return if this instance is greater than the [other].
  ///
  bool operator >(covariant MoneyTransactions other) => compareTo(other) > 0;
}

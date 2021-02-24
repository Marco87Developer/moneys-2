import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:moneys/src/enumerations/income_or_expense.dart';

import '../../moneys.dart';

/// This class models an history of transactions. It has methods in order to
/// manage that history.
///
class Transactions implements Comparable {
  /// Default constructor.
  ///
  Transactions();

  /// Returns a instance of `Transactions` with the history contained in the
  /// [listOfMaps].
  ///
  Transactions.fromListOfMaps(List<Map<String, dynamic>> listOfMaps) {
    for (final Map<String, dynamic> map in listOfMaps) {
      _history.add(Transaction.fromMap(map));
    }
  }

  final SplayTreeSet<Transaction> _history = SplayTreeSet();

  /// Returns an unmodifiable `List` of the *entire* [history] of the
  /// transactions.
  ///
  List<Transaction> get history => List.unmodifiable(_history.toList());

  /// Adds the [transaction] to the history of the transactions.
  ///
  void add(Transaction transaction) => _history.add(transaction);

  double _historyReduced() {
    double sum = 0;

    for (final Transaction transaction in history) {
      sum += transaction.value.amount;
    }

    return sum;
  }

  /// Returns an unmodifiable list of all transactions made on the [dateTime].
  ///
  List<Transaction> madeAtDateTime(DateTime dateTime) {
    final List<Transaction> filtered = _history
        .where((transaction) => transaction.dateTime.isAtSameMomentAs(dateTime))
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Returns an unmodifiable list of all transactions made on the [dateTime] or
  /// *after*.
  ///
  List<Transaction> madeAtDateTimeOrAfter(DateTime dateTime) {
    final List<Transaction> filtered = _history
        .where((transaction) =>
            transaction.dateTime.isAtSameMomentAs(dateTime) ||
            transaction.dateTime.isAfter(dateTime))
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Returns an unmodifiable list of all transactions made on the [dateTime] of
  /// *before*.
  ///
  List<Transaction> madeAtDateTimeOrBefore(DateTime dateTime) {
    final List<Transaction> filtered = _history
        .where((transaction) =>
            transaction.dateTime.isAtSameMomentAs(dateTime) ||
            transaction.dateTime.isBefore(dateTime))
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Removes the [transaction] from the history of the transactions.
  ///
  void remove(Transaction transaction) => _history.remove(transaction);

  /// Generates a `List<Map<String, dynamic>>` where the elements are
  /// representations of all the transactions saved in this instance.
  ///
  List<Map<String, dynamic>> toListOfMaps() => [
        for (Transaction transaction in history) transaction.toMap(),
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
      for (final Transaction transaction in _history) {
        if (transaction.incomeOrExpense == incomeOrExpense) {
          result += transaction.value;
        }
      }

      return result;
    }

    /// Only [until] is specified.
    if (from == null && until != null) {
      for (final Transaction transaction in _history) {
        if (transaction.incomeOrExpense == incomeOrExpense &&
            (transaction.dateTime.isBefore(until) ||
                transaction.dateTime.isAtSameMomentAs(until))) {
          result += transaction.value;
        }
      }

      return result;
    }

    /// Only [from] is specified.
    if (from != null && until == null) {
      for (final Transaction transaction in _history) {
        if (transaction.incomeOrExpense == incomeOrExpense &&
            (transaction.dateTime.isAfter(from) ||
                transaction.dateTime.isAtSameMomentAs(from))) {
          result += transaction.value;
        }
      }

      return result;
    }

    /// Both [from] and [until] are specified.
    if (from != null && until != null) {
      for (final Transaction transaction in _history) {
        if (transaction.incomeOrExpense == incomeOrExpense &&
            (transaction.dateTime.isAfter(from) ||
                transaction.dateTime.isAtSameMomentAs(from)) &&
            (transaction.dateTime.isBefore(until) ||
                transaction.dateTime.isAtSameMomentAs(until))) {
          result += transaction.value;
        }
      }

      return result;
    }

    return result;
  }

  /// Returns an unmodifiable list of all the transactions in whose method was
  /// [method].
  ///
  List<Transaction> whoseMethodWas(TransactionMethod method) {
    final List<Transaction> filtered =
        _history.where((transaction) => transaction.method == method).toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value >=
  /// [value].
  ///
  List<Transaction> withValueGreaterThanOrEqualTo(Money value) {
    final List<Transaction> filtered =
        _history.where((transaction) => transaction.value >= value).toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value >
  /// [value].
  ///
  List<Transaction> withValueGreaterThan(Money value) {
    final List<Transaction> filtered =
        _history.where((transaction) => transaction.value > value).toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value <
  /// [value].
  ///
  List<Transaction> withValueLessThan(Money value) {
    final List<Transaction> filtered =
        _history.where((transaction) => transaction.value < value).toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the transactions with a value <=
  /// [value].
  ///
  List<Transaction> withValueLessThanOrEqualTo(Money value) {
    final List<Transaction> filtered =
        _history.where((transaction) => transaction.value <= value).toList();

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
  int compareTo(covariant Transactions other) {
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
  bool operator <(covariant Transactions other) => compareTo(other) < 0;

  /// Return if this instance is less than or equal to the [other].
  ///
  bool operator <=(covariant Transactions other) => compareTo(other) <= 0;

  @override
  bool operator ==(covariant Transactions other) => compareTo(other) == 0;

  /// Return if this instance is greater than or equal to the [other].
  ///
  bool operator >=(covariant Transactions other) => compareTo(other) >= 0;

  /// Return if this instance is greater than the [other].
  ///
  bool operator >(covariant Transactions other) => compareTo(other) > 0;
}

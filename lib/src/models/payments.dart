import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:moneys/src/enumerations/income_or_expense.dart';

import '../../moneys.dart';

/// This class models an history of payments. It has methods in order to manage
/// that history.
///
class Payments implements Comparable {
  /// Default constructor.
  ///
  Payments();

  /// Returns a instance of `Payments` with the history contained in the
  /// [listOfMaps].
  ///
  Payments.fromListOfMaps(List<Map<String, dynamic>> listOfMaps) {
    for (final Map<String, dynamic> map in listOfMaps) {
      _history.add(Payment.fromMap(map));
    }
  }

  final SplayTreeSet<Payment> _history = SplayTreeSet();

  /// Returns an unmodifiable `List` of the *entire* [history] of the payments.
  ///
  List<Payment> get history => List.unmodifiable(_history.toList());

  /// Adds the [payment] to the history of the payments.
  ///
  void add(Payment payment) => _history.add(payment);

  /// Returns an unmodifiable list of all payments made on the [dateTime].
  ///
  List<Payment> madeAtDateTime(DateTime dateTime) {
    final List<Payment> filtered = _history
        .where((payment) => payment.dateTime.isAtSameMomentAs(dateTime))
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Returns an unmodifiable list of all payments made on the [dateTime] or *after*.
  ///
  List<Payment> madeAtDateTimeOrAfter(DateTime dateTime) {
    final List<Payment> filtered = _history
        .where((payment) =>
            payment.dateTime.isAtSameMomentAs(dateTime) ||
            payment.dateTime.isAfter(dateTime))
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Returns an unmodifiable list of all payments made on the [dateTime] of *before*.
  ///
  List<Payment> madeAtDateTimeOrBefore(DateTime dateTime) {
    final List<Payment> filtered = _history
        .where((payment) =>
            payment.dateTime.isAtSameMomentAs(dateTime) ||
            payment.dateTime.isBefore(dateTime))
        .toList();

    return List.unmodifiable(filtered);
  }

  /// Removes the [payment] from the history of the payments.
  ///
  void remove(Payment payment) => _history.remove(payment);

  /// Generates a `List<Map<String, dynamic>>` where the elements are
  /// representations of all the payments saved in this instance.
  ///
  List<Map<String, dynamic>> toListOfMaps() => [
        for (Payment payment in history) payment.toMap(),
      ];

  /// Return the total of the payments.
  ///
  /// It is possible to have the total of *all* the payments, the incomes or the
  /// expenses (that is, taking into account the entire [history]). Also, it is
  /// possible to filter with respect to [from] and [until] dates, or only one
  /// of these two dates, or none.
  ///
  Money total({
    DateTime? from,
    required ExpenseOrIncome incomeOrExpense,
    DateTime? until,
  }) {
    final Currency currency = _history.first.value.currency;

    Money result = Money(amount: 0, currency: currency);

    if (from == null && until == null) {
      for (final Payment payment in _history) {
        if (payment.incomeOrExpense == incomeOrExpense) {
          result += payment.value;
        }
      }

      return result;
    }

    /// Only [until] is specified.
    if (from == null && until != null) {
      for (final Payment payment in _history) {
        if (payment.incomeOrExpense == incomeOrExpense &&
            (payment.dateTime.isBefore(until) ||
                payment.dateTime.isAtSameMomentAs(until))) {
          result += payment.value;
        }
      }

      return result;
    }

    /// Only [from] is specified.
    if (from != null && until == null) {
      for (final Payment payment in _history) {
        if (payment.incomeOrExpense == incomeOrExpense &&
            (payment.dateTime.isAfter(from) ||
                payment.dateTime.isAtSameMomentAs(from))) {
          result += payment.value;
        }
      }

      return result;
    }

    /// Both [from] and [until] are specified.
    if (from != null && until != null) {
      for (final Payment payment in _history) {
        if (payment.incomeOrExpense == incomeOrExpense &&
            (payment.dateTime.isAfter(from) ||
                payment.dateTime.isAtSameMomentAs(from)) &&
            (payment.dateTime.isBefore(until) ||
                payment.dateTime.isAtSameMomentAs(until))) {
          result += payment.value;
        }
      }

      return result;
    }

    return result;
  }

  /// Returns an unmodifiable list of all the payments in whose method was
  /// [method].
  ///
  List<Payment> whoseMethodWas(PaymentMethod method) {
    final List<Payment> filtered =
        _history.where((payment) => payment.method == method).toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the payments with a value greater than
  /// or equal to [value].
  ///
  List<Payment> withValueGreaterThanOrEqualTo(Money value) {
    final List<Payment> filtered =
        _history.where((payment) => payment.value >= value).toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the payments with a value greater than
  /// [value].
  ///
  List<Payment> withValueGreaterThan(Money value) {
    final List<Payment> filtered =
        _history.where((payment) => payment.value > value).toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the payments with a value less than
  /// [value].
  ///
  List<Payment> withValueLessThan(Money value) {
    final List<Payment> filtered =
        _history.where((payment) => payment.value < value).toList();

    return List.unmodifiable(filtered);
  }

  /// Return an unmodifiable list of all the payments with a value less than or
  /// equal to [value].
  ///
  List<Payment> withValueLessThanOrEqualTo(Money value) {
    final List<Payment> filtered =
        _history.where((payment) => payment.value <= value).toList();

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
  int compareTo(covariant Payments other) {
    for (int i = 0; i < history.length; i++) {
      final int comparison = history[i].compareTo(other.history[i]);
      if (comparison != 0) return comparison;
    }

    return 0;
  }

  @override
  int get hashCode => hashValues(history, history.length);

  /// Returns if this instance is less than the [other].
  ///
  bool operator <(covariant Payments other) => compareTo(other) < 0;

  /// Return if this instance is less than or equal to the [other].
  ///
  bool operator <=(covariant Payments other) => compareTo(other) <= 0;

  @override
  bool operator ==(covariant Payments other) => compareTo(other) == 0;

  /// Return if this instance is greater than or equal to the [other].
  ///
  bool operator >=(covariant Payments other) => compareTo(other) >= 0;

  /// Return if this instance is greater than the [other].
  ///
  bool operator >(covariant Payments other) => compareTo(other) > 0;
}

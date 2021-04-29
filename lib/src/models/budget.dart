import 'package:flutter/material.dart';

import '../enumerations/expense_or_income.dart';
import '../enumerations/renewal.dart';
import '../models/money.dart';
import '../models/money_transactions.dart';

const String _nameKey = 'name';
const String _renewalKey = 'renewal';
const String _sizeKey = 'size';
const String _startKey = 'start';
const String _transactionsKey = 'transactions';

/// This class models a budget.
///
@immutable
class Budget implements Comparable {
  /// A budget.
  ///
  const Budget({
    required this.name,
    required this.renewal,
    required this.size,
    required this.start,
    required this.transactions,
  });

  /// Creates an `Budget` instance starting from a `Map<String, dynamic> map`.
  ///
  /// This can be useful for retrieving the instance in a database.
  ///
  Budget.fromMap(Map<String, dynamic> map)
      : name = map[_nameKey],
        renewal = '${map[_renewalKey]}'.toRenewal(),
        size = '${map[_sizeKey]}'.toMoney(),
        start = DateTime.parse(map[_startKey]),
        transactions = MoneyTransactions.fromListOfMaps(map[_transactionsKey]);

  /// The name that identifies this budget.
  final String name;

  /// The renewal period of this budget.
  final Renewal renewal;

  /// The size of this budget expressed in money.
  final Money size;

  /// The actual start of this budget.
  final DateTime start;

  /// The history of all the transactions related with this budget.
  final MoneyTransactions transactions;

  /// Gets the number of days between the last renewal and the next one. In the
  /// case of monthly renewal, the value returned depends on the month in which
  /// [from] date is. If [from] is not provided, `DateTime.now()` date is taken,
  /// as it is for `lastRenewal()` and `nextRenewal` methods.
  ///
  int daysBetweenRenewals({
    DateTime? from,
  }) {
    from ??= DateTime.now();

    return nextRenewal(from: from).difference(lastRenewal(from: from)).inDays;
  }

  /// Returns the total of the incomes. These can be filtered with respect to
  /// [from] and [until] dates, or only one of these two dates, or none (in
  /// which case returns the total over the entire history of the transactions).
  ///
  Money earned({
    DateTime? from,
    DateTime? until,
  }) =>
      transactions.total(
        from: from,
        incomeOrExpense: ExpenseOrIncome.income,
        until: until,
      );

  /// Returns the last renewal starting from [from] date. If [from] is not
  /// provided, `DateTime.now()` date is taken.
  ///
  DateTime lastRenewal({
    DateTime? from,
  }) {
    from ??= DateTime.now();

    switch (renewal) {
      case Renewal.annual:
        final DateTime thisYearRenewal = DateTime(
          from.year,
          start.month,
          start.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );
        final DateTime lastYearRenewal = DateTime(
          from.year - 1,
          start.month,
          start.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );

        return from.isAtSameMomentAs(thisYearRenewal) ||
                from.isAfter(thisYearRenewal)
            ? thisYearRenewal
            : lastYearRenewal;
      case Renewal.daily:
        final DateTime todayRenewal = DateTime(
          from.year,
          from.month,
          from.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );
        final DateTime yesterdayRenewal = DateTime(
          from.year,
          from.month,
          from.day - 1,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );

        return from.isAtSameMomentAs(todayRenewal) || from.isAfter(todayRenewal)
            ? todayRenewal
            : yesterdayRenewal;
      case Renewal.monthly:
        final DateTime thisMonthRenewal = DateTime(
          from.year,
          from.month,
          start.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );
        final DateTime lastMonthRenewal = DateTime(
          from.year,
          from.month - 1,
          start.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );

        return from.isAtSameMomentAs(thisMonthRenewal) ||
                from.isAfter(thisMonthRenewal)
            ? thisMonthRenewal
            : lastMonthRenewal;
      case Renewal.weekly:
        final int startWeekDay = start.weekday;
        final int fromWeekDay = from.weekday;

        return DateTime(
          from.year,
          from.month,
          from.day - (fromWeekDay - startWeekDay) % 7,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );
    }
  }

  /// Returns the next renewal starting from [from] date. If [from] is not
  /// provided, `DateTime.now()` date is taken.
  ///
  DateTime nextRenewal({
    DateTime? from,
  }) {
    from ??= DateTime.now();

    switch (renewal) {
      case Renewal.annual:
        final DateTime thisYearRenewal = DateTime(
          from.year,
          start.month,
          start.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );
        final DateTime nextYearRenewal = DateTime(
          from.year + 1,
          start.month,
          start.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );

        return from.isBefore(thisYearRenewal)
            ? thisYearRenewal
            : nextYearRenewal;
      case Renewal.daily:
        final DateTime todayRenewal = DateTime(
          from.year,
          from.month,
          from.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );
        final DateTime tomorrowRenewal = DateTime(
          from.year,
          from.month,
          from.day + 1,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );

        return from.isBefore(todayRenewal) ? todayRenewal : tomorrowRenewal;
      case Renewal.monthly:
        final DateTime thisMonthRenewal = DateTime(
          from.year,
          from.month,
          start.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );
        final DateTime nextMonthRenewal = DateTime(
          from.year,
          from.month + 1,
          start.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );

        return from.isBefore(thisMonthRenewal)
            ? thisMonthRenewal
            : nextMonthRenewal;
      case Renewal.weekly:
        final int startWeekDay = start.weekday;
        final int fromWeekDay = from.weekday;

        return DateTime(
          from.year,
          from.month,
          fromWeekDay == startWeekDay
              ? from.day + 7
              : from.day + (startWeekDay - fromWeekDay) % 7,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );
    }
  }

  /// Returns the total of the expenses. These can be filtered with respect to
  /// [from] and [until] dates, or only one of these two dates, or none (in
  /// which case returns the total over the entire history of the transactions).
  ///
  Money spent({
    DateTime? from,
    DateTime? until,
  }) =>
      transactions.total(
        from: from,
        incomeOrExpense: ExpenseOrIncome.expense,
        until: until,
      );

  /// Creates a `Map<String, dynamic> map` representation of this instance.
  ///
  /// This can be useful for saving the instance in a database.
  ///
  Map<String, dynamic> toMap() => {
        _nameKey: name,
        _renewalKey: renewal.string(),
        _sizeKey: '$size',
        _startKey: start.toIso8601String(),
        _transactionsKey: transactions.toListOfMaps(),
      };

  /// The order of the comparisons is:
  ///
  /// 1. [name]
  /// 2. [start]
  /// 3. [renewal]
  /// 4. [size]
  /// 5. [transactions]
  ///
  @override
  int compareTo(covariant Budget other) {
    // 1º comparison
    final int comparison1 = name.compareTo(other.name);
    if (comparison1 != 0) return comparison1;

    // 2º comparison
    final int comparison2 = start.compareTo(other.start);
    if (comparison2 != 0) return comparison2;

    // 3º comparison
    final int comparison3 = renewal.value().compareTo(other.renewal.value());
    if (comparison3 != 0) return comparison3;

    // 4º comparison
    final int comparison4 = size.compareTo(other.size);
    if (comparison4 != 0) return comparison4;

    // Last comparison
    final int comparison5 = transactions.compareTo(other.transactions);
    return comparison5;
  }

  @override
  int get hashCode => hashValues(
        name,
        renewal,
        size,
        start,
        transactions,
      );

  /// Returns if this instance is less than the [other].
  ///
  bool operator <(covariant Budget other) => compareTo(other) < 0;

  /// Return if this instance is less than or equal to the [other].
  ///
  bool operator <=(covariant Budget other) => compareTo(other) <= 0;

  @override
  bool operator ==(covariant Budget other) => compareTo(other) == 0;

  /// Return if this instance is greater than or equal to the [other].
  ///
  bool operator >=(covariant Budget other) => compareTo(other) >= 0;

  /// Return if this instance is greater than the [other].
  ///
  bool operator >(covariant Budget other) => compareTo(other) > 0;
}

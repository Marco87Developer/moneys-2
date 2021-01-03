import 'package:flutter/material.dart';
import 'package:moneys/src/enumerations/income_or_expense.dart';

import '../enumerations/payment_method.dart';
import 'money.dart';

const String _dateTimeKey = 'dateTime';
const String _idKey = 'id';
const String _incomeOrExpenseKey = 'incomeOrExpense';
const String _methodKey = 'method';
const String _valueKey = 'value';

/// This class models a representation of a payment.
///
class Payment implements Comparable {
  /// Representation of a payment.
  ///
  /// It **requires** these fields: `DateTime` [dateTime], `String` [id],
  /// `IncomeOrExpense` [incomeOrExpense], `PaymentMethod` [method] and
  /// `Money` [value].
  ///
  const Payment({
    required this.dateTime,
    required this.id,
    required this.incomeOrExpense,
    required this.method,
    required this.value,
  });

  /// Creates an `Payment` instance starting from a `Map<String, dynamic> map`.
  ///
  /// This can be useful for retrieving the instance in a database.
  ///
  Payment.fromMap(Map<String, dynamic> map)
      : dateTime = DateTime.parse('${map[_dateTimeKey]}'),
        id = map[_idKey],
        incomeOrExpense = '${map[_incomeOrExpenseKey]}'.toIncomeOrExpense(),
        method = '${map[_methodKey]}'.toPaymentMethod(),
        value = '${map[_valueKey]}'.toMoney();

  /// The date and time when this payment is made.
  final DateTime dateTime;

  /// The identificator of this payment. It should be unique.
  final String id;

  /// Indicates whether this payment is an income or an expense.
  final IncomeOrExpense incomeOrExpense;

  /// The method used for this payment.
  final PaymentMethod method;

  /// The value, or amount, of this payment.
  final Money value;

  /// Creates a `Map<String, dynamic> map` representation of this instance.
  ///
  /// This can be useful for saving the instance in a database.
  ///
  Map<String, dynamic> toMap() => {
        _dateTimeKey: dateTime.toIso8601String(),
        _idKey: id,
        _incomeOrExpenseKey: incomeOrExpense.string(),
        _methodKey: method.string(),
        _valueKey: '$value',
      };

  /// The order of the comparisons is:
  ///
  /// 1. [dateTime]
  /// 2. [value]
  /// 3. [method]
  /// 4. [id]
  ///
  @override
  int compareTo(covariant Payment other) {
    // 1º comparison
    final int comparison1 = dateTime.compareTo(other.dateTime);
    if (comparison1 != 0) return comparison1;

    // 2º comparison
    final int comparison2 = value.compareTo(other.value);
    if (comparison2 != 0) return comparison2;

    // 3º comparison
    final int comparison3 = method.string().compareTo(other.method.string());
    if (comparison3 != 0) return comparison3;

    // Last comparison
    final int comparison4 = id.compareTo(other.id);
    return comparison4;
  }

  @override
  int get hashCode => hashValues(dateTime, method, value);

  /// Returns if this instance is less than the [other].
  ///
  bool operator <(covariant Payment other) => compareTo(other) < 0;

  /// Return if this instance is less than or equal to the [other].
  ///
  bool operator <=(covariant Payment other) => compareTo(other) <= 0;

  @override
  bool operator ==(covariant Payment other) => compareTo(other) == 0;

  /// Return if this instance is greater than or equal to the [other].
  ///
  bool operator >=(covariant Payment other) => compareTo(other) >= 0;

  /// Return if this instance is greater than the [other].
  ///
  bool operator >(covariant Payment other) => compareTo(other) > 0;
}

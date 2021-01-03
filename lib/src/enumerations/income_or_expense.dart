import 'package:flutter/foundation.dart';

/// The values of this enumeration indicate whether a payment is an [income] or
/// an [expense].
///
enum IncomeOrExpense {
  /// Expense
  expense,

  /// Income
  income,
}

/// This extension adds functionality to the `IncomeOrExpense` enumeration
/// values.
///
extension IncomeOrExpenseX on IncomeOrExpense {
  /// Returns the corresponding string value of this `IncomeOrExpense` value.
  ///
  String string() => describeEnum(this);
}

/// This extension provides useful tools in order to convert a `String` into a
/// `IncomeOrExpense` value.
///
extension StringToIncomeOrExpenseX on String {
  /// Converts this string into the corresponding `IncomeOrExpense` value.
  ///
  IncomeOrExpense toIncomeOrExpense() {
    for (final IncomeOrExpense incomeOrExpense in IncomeOrExpense.values)
      if (this == incomeOrExpense.string()) return incomeOrExpense;

    throw FormatException(
        'The string does not contains a valid IncomeOrExpense representation.');
  }
}

import 'package:flutter/foundation.dart';

/// The values of this enumeration indicate whether a transaction is an
/// [expense] or an [income].
///
enum ExpenseOrIncome {
  /// Expense
  expense,

  /// Income
  income,
}

/// This extension adds functionality to the `ExpenseOrIncome` enumeration
/// values.
///
extension ExpenseOrIncomeX on ExpenseOrIncome {
  /// Returns the corresponding string value of this `ExpenseOrIncome` value.
  ///
  String string() => describeEnum(this);
}

/// This extension provides useful tools in order to convert a `String` into a
/// `ExpenseOrIncome` value.
///
extension StringToExpenseOrIncomeX on String {
  /// Converts this string into the corresponding `ExpenseOrIncome` value.
  ///
  ExpenseOrIncome toExpenseOrIncome() {
    for (final ExpenseOrIncome expenseOrIncome in ExpenseOrIncome.values)
      if (this == expenseOrIncome.string()) return expenseOrIncome;

    throw FormatException(
        'The string does not contains a valid ExpenseOrIncome representation.');
  }
}
